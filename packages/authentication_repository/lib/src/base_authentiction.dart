import 'dart:async';

import 'package:authentication_repository/src/models/userinfo.dart';
import 'package:oauth2/oauth2.dart';

/// 取消授权异常
class CancelAuthorization implements Exception {
  CancelAuthorization([this.error]);

  final dynamic error;
}

abstract class OfflineAccessProvider {
  /// 刷新token，如果刷新失败，则返回null值，不抛出异常
  Future<Credentials?> refreshToken(Credentials credentials);

  /// 撤销token，失败不抛出异常
  FutureOr<void> revocationToken(Credentials credentials);
}

abstract class PasswordGrantProvider {
  PasswordGrantProvider();

  Userinfo get userinfo;

  Credentials get credentials;

  Future<void> handleResourceOwnerPassword(String email, String password);

  Future<void> handleUserinfo();

  void clear();
}

abstract class AuthorizationCodeGrantProvider {
  AuthorizationCodeGrantProvider();

  Userinfo get userinfo;

  Credentials get credentials;

  Future<Uri> handleResponseUrl();

  /// 处理用户的授权
  ///
  /// 如果用户取消授权会抛出[CancelAuthorization]异常
  Future<void> handleAuthorizationResponse(Uri responseUrl);

  Future<void> handleUserinfo();

  void clear();
}
