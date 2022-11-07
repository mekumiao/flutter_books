import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/src/base_authentiction.dart';
import 'package:authentication_repository/src/id4/id4_authorization_code_grant_provider.dart';
import 'package:authentication_repository/src/id4/id4_offline_access_provider.dart';
import 'package:authentication_repository/src/id4/id4_password_grant_provider.dart';
import 'package:authentication_repository/src/mock/mock_authorization_code_grant_provider.dart';
import 'package:authentication_repository/src/mock/mock_offline_access_provider.dart';
import 'package:authentication_repository/src/mock/mock_password_grant_provider.dart';
import 'package:authentication_repository/src/models/models.dart';
import 'package:diagnose_logger/diagnose_logger.dart';
import 'package:flutter/material.dart';
import 'package:helper/helper.dart';
import 'package:oauth2/oauth2.dart';
import 'package:synchronized/synchronized.dart';

/// 刷新token失败时抛出的异常
///
/// code=1 => 未登录
///
/// code=2 => 登录已过期
class RefreshTokenError implements Exception {
  RefreshTokenError(this.code, this.message);

  final int code;
  final String message;
}

class AuthenticationRepository {
  AuthenticationRepository({
    required OfflineAccessProvider offlineAccessProvider,
    required PasswordGrantProvider passwordGrantProvider,
    AuthorizationCodeGrantProvider? authorizationCodeGrantProvider,
  })  : _offlineAccessProvider = offlineAccessProvider,
        _passwordGrantProvider = passwordGrantProvider,
        _authorizationCodeGrantProvider = authorizationCodeGrantProvider;

  factory AuthenticationRepository.id4() {
    return AuthenticationRepository(
      offlineAccessProvider: Id4OfflineAccessProvider.standard(),
      passwordGrantProvider: Id4PasswordGrantProvider.standard(),
      authorizationCodeGrantProvider: Platform.isAndroid || Platform.isWindows
          ? Id4AuthorizationCodeGrantProvider.standard()
          : null,
    );
  }

  factory AuthenticationRepository.mock() {
    return AuthenticationRepository(
      offlineAccessProvider: MockOfflineAccessProvider.standard(),
      passwordGrantProvider: MockPasswordGrantProvider.standard(),
      authorizationCodeGrantProvider:
          MockAuthorizationCodeGrantProvider.standard(),
    );
  }

  final OfflineAccessProvider _offlineAccessProvider;
  final PasswordGrantProvider _passwordGrantProvider;
  final AuthorizationCodeGrantProvider? _authorizationCodeGrantProvider;

  final _lock = Lock();
  final _userStream = StreamController<User>.broadcast();

  Credentials? _credentials;
  User? _currentUser;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';
  @visibleForTesting
  static const credentialsCacheKey = '__credentials_cache_key__';

  Stream<User> get user => _userStream.stream;

  User get currentUser {
    return _currentUser ??= SpUtil.getObj(
      userCacheKey,
      (v) => User.fromJson(v as Map<String, dynamic>),
      defValue: User.empty,
    )!;
  }

  bool get shouldRefreshToken {
    final cre = _readCredentials();
    return cre != null && cre.isExpired && cre.canRefresh;
  }

  Future<String?> get token async {
    if (shouldRefreshToken) {
      try {
        await refreshToken();
      } on RefreshTokenError catch (e) {
        Log.logger.e('err: RefreshTokenError', e);
      }
    }
    Log.logger.v('call token');
    return _credentials?.accessToken;
  }

  Credentials? _readCredentials() {
    if (_credentials != null) return _credentials;

    final json = SpUtil.getString(credentialsCacheKey)!;
    if (json.isNotEmpty == true) {
      try {
        return _credentials = Credentials.fromJson(json);
      } catch (e) {
        _removeCredentials();
      }
    }
    return null;
  }

  Future<void> _saveCredentials(Credentials credentials) async {
    _credentials = credentials;
    await SpUtil.putString(credentialsCacheKey, credentials.toJson());
  }

  Future<Credentials?> _removeCredentials() async {
    final cre = _readCredentials();
    _credentials = null;
    await SpUtil.remove(credentialsCacheKey);
    return cre;
  }

  Future<void> _saveUser(User user) async {
    _currentUser = user;
    await SpUtil.putObject(userCacheKey, user);
  }

  Future<User?> _removeUser() async {
    final us = _currentUser;
    _currentUser = User.empty;
    await SpUtil.remove(userCacheKey);
    return us;
  }

  /// 序列化执行刷新token操作
  ///
  /// 当刷新失败时，将退出登录并抛出异常`RefreshTokenError`
  Future<void> refreshToken() async {
    Log.logger.d('call refreshToken');
    await _lock.synchronized(() async {
      await _refreshToken();
    });
  }

  /// 刷新token
  ///
  /// 当刷新失败时，将退出登录并抛出异常`RefreshTokenError`
  Future<void> _refreshToken() async {
    final cre = _readCredentials();
    if (cre == null || (cre.isExpired && !cre.canRefresh)) {
      unawaited(logOut());
      throw RefreshTokenError(1, 'Not logged in');
    }
    if (cre.isExpired && cre.canRefresh) {
      final crec = await _offlineAccessProvider.refreshToken(cre);
      if (crec == null) {
        unawaited(logOut());
        throw RefreshTokenError(2, 'Login credentials have expired');
      }
      await _saveCredentials(crec);
      Log.logger.i('refresh token success: ${crec.accessToken}');
    }
    _userStream.add(currentUser);
  }

  /// 使用邮箱和密码登录
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _passwordGrantProvider.handleResourceOwnerPassword(
        email,
        password,
      );
      await _saveCredentials(_passwordGrantProvider.credentials);
      await _passwordGrantProvider.handleUserinfo();
      final user = _passwordGrantProvider.userinfo.toUser;
      await _saveUser(user);
      _userStream.add(user);
    } catch (e) {
      Log.logger.e('login error', e);
      rethrow;
    } finally {
      _passwordGrantProvider.clear();
    }
  }

  /// 使用自定义的id4服务登录
  Future<void> logInWithID4() async {
    assert(
      _authorizationCodeGrantProvider != null,
      '_authorizationCodeGrantProvider is not null',
    );
    try {
      final uri = await _authorizationCodeGrantProvider!.handleResponseUrl();
      await _authorizationCodeGrantProvider!.handleAuthorizationResponse(uri);
      await _saveCredentials(_authorizationCodeGrantProvider!.credentials);
      await _authorizationCodeGrantProvider!.handleUserinfo();
      final user = _authorizationCodeGrantProvider!.userinfo.toUser;
      await _saveUser(user);
      _userStream.add(user);
      _authorizationCodeGrantProvider!.clear();
    } on CancelAuthorization catch (e) {
      Log.logger.e('login cancel', e);
    } catch (e) {
      Log.logger.e('login error', e);
      rethrow;
    } finally {
      _authorizationCodeGrantProvider!.clear();
    }
  }

  /// 退出登录
  Future<void> logOut() async {
    _userStream.add(User.empty);
    await _removeUser();
    final cre = await _removeCredentials();
    if (cre != null) {
      await _offlineAccessProvider.revocationToken(cre);
    }
  }

  /// 清理用户和认证数据。 一般在开发环境中使用
  Future<void> clear() async {
    await _removeUser();
    await _removeCredentials();
  }
}

extension on Userinfo {
  User get toUser {
    return User(
      id: sub,
      name: name,
      role: role,
      picture: picture,
    );
  }
}
