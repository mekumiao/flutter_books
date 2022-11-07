import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_repository/src/base_authentiction.dart';
import 'package:authentication_repository/src/id4/id4_onfig.dart' as config;
import 'package:authentication_repository/src/models/models.dart';
import 'package:diagnose_logger/diagnose_logger.dart';
import 'package:flutter/services.dart';
import 'package:helper/helper.dart';
import 'package:oauth2/oauth2.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

const _timeout = Duration(seconds: 60 * 5);

class Id4AuthorizationCodeGrantProvider extends AuthorizationCodeGrantProvider {
  Id4AuthorizationCodeGrantProvider({
    required this.clientId,
    required this.clientSecret,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.redirectUrl,
    required this.scopes,
    required this.userinfoEndpoint,
    required this.listenRedirectUri,
  });

  factory Id4AuthorizationCodeGrantProvider.standard() {
    return Id4AuthorizationCodeGrantProvider(
      clientId: config.clientId,
      clientSecret: config.clientSecret,
      userinfoEndpoint: config.userinfoEndpoint,
      authorizationEndpoint: config.authorizationEndpoint,
      tokenEndpoint: config.tokenEndpoint,
      scopes: config.scopes,
      redirectUrl: Platform.isAndroid
          ? config.redirectUrlForAndroid
          : Platform.isWindows
              ? config.redirectUrlForWindows
              : throw Exception('该平台暂不支持授权码方式认证'),
      listenRedirectUri: Platform.isAndroid
          ? _ListenRedirectUriForAndroidPlatform().listen
          : Platform.isWindows
              ? _ListenRedirectUriForWindowsPlatform().listen
              : throw Exception('该平台暂不支持授权码方式认证'),
    );
  }

  final String clientId;
  final String clientSecret;
  final Uri authorizationEndpoint;
  final Uri userinfoEndpoint;
  final Uri tokenEndpoint;
  final Uri redirectUrl;
  final List<Scope> scopes;
  final ListenRedirectUri listenRedirectUri;

  AuthorizationCodeGrant? _grant;

  Uri? _responseUrl;
  Userinfo? _userinfo;
  Client? _client;

  Uri? get responseUrl => _responseUrl;
  @override
  Userinfo get userinfo {
    if (_userinfo != null) return _userinfo!;
    throw Exception('没有获取userinfo信息');
  }

  AuthorizationCodeGrant _createGrant() {
    return _grant = AuthorizationCodeGrant(
      clientId,
      authorizationEndpoint,
      tokenEndpoint,
      secret: clientSecret,
    );
  }

  @override
  Future<Uri> handleResponseUrl() async {
    final grant = _createGrant();
    final authorizationUrl = grant.getAuthorizationUrl(
      redirectUrl,
      scopes: scopes.map((e) => e.name),
      state: RandomHelper.generateRandomString(),
    );
    try {
      return await listenRedirectUri(authorizationUrl).timeout(_timeout);
    } catch (e) {
      Log.logger.e('处理重定向url失败', e);
      throw CancelAuthorization();
    }
  }

  @override
  Future<void> handleAuthorizationResponse(Uri responseUrl) async {
    assert(_grant != null, '_grant is not null');
    try {
      final client = await _grant!
          .handleAuthorizationResponse(responseUrl.queryParameters);
      final resultScopes = client.credentials.scopes;
      if (resultScopes == null) throw Exception('没有授予任何权限');
      if (scopes
          .where((e) => e.isRequired)
          .map((e) => e.name)
          .every(resultScopes.contains)) {
        _client = client;
        return;
      }
      throw Exception('有app所必须的权限范围没有被授予');
    } catch (e) {
      Log.logger.e('处理认证结果时出错', e);
      rethrow;
    }
  }

  @override
  Future<void> handleUserinfo() async {
    assert(_client != null, '_client is not null');
    try {
      final resp = await _client!.get(userinfoEndpoint);
      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.body) as Map<String, dynamic>;
        _userinfo = Userinfo.fromJson(json);
      }
    } catch (e) {
      Log.logger.e('处理用户信息时出错', e);
      rethrow;
    }
  }

  @override
  void clear() {
    _responseUrl = null;
    _userinfo = null;
    _client?.close();
    _client = null;
    _grant?.close();
    _grant = null;
  }

  @override
  Credentials get credentials {
    if (_client != null) return _client!.credentials;
    throw Exception('_client is null');
  }
}

typedef ListenRedirectUri = Future<Uri> Function(Uri redirectUri);

class _ListenRedirectUriForAndroidPlatform {
  factory _ListenRedirectUriForAndroidPlatform() {
    return _instance ?? _ListenRedirectUriForAndroidPlatform._();
  }

  _ListenRedirectUriForAndroidPlatform._();

  static final String _host = config.redirectUrlForAndroid.host;

  ListenRedirectUri get listen => _listen;

  static _ListenRedirectUriForAndroidPlatform? _instance;

  StreamSubscription<Uri?>? _streamSubscription;

  static Future<void> _openUri(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('不能打开uri');
    }
  }

  Future<void> _close() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  Future<Uri> _listen(Uri redirectUrl) async {
    await _close();
    await _openUri(redirectUrl);

    final state = redirectUrl.queryParameters['state'];
    final completer = Completer<Uri>();

    final streamSubscription = _streamSubscription = uriLinkStream.listen(
      (Uri? uri) {
        if (uri?.host == _host) {
          final qstate = uri?.queryParameters['state'];
          if (state == null || state == qstate) {
            completer.complete(uri);
          }
        }
      },
      onError: (dynamic err) {
        completer.completeError(CancelAuthorization(err));
      },
      onDone: () {
        completer.completeError(
          CancelAuthorization('ListenRedirectUriForMobilePlatform listen end'),
        );
      },
      cancelOnError: true,
    );
    return completer.future.whenComplete(() async {
      await streamSubscription.cancel();
      _streamSubscription = null;
    });
  }
}

class _ListenRedirectUriForWindowsPlatform {
  factory _ListenRedirectUriForWindowsPlatform() {
    return _instance ?? _ListenRedirectUriForWindowsPlatform._();
  }
  _ListenRedirectUriForWindowsPlatform._();

  ListenRedirectUri get listen => _listen;

  static const String _htmlPath =
      'packages/authentication_repository/files/authorization.html';

  static _ListenRedirectUriForWindowsPlatform? _instance;

  HttpServer? _httpServer;
  StreamSubscription<HttpRequest?>? _streamSubscription;

  static Future<void> _openUri(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('不能打开uri');
    }
  }

  Future<void> _close() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    await _httpServer?.close(force: true);
    _httpServer = null;
  }

  Future<Uri> _listen(Uri redirectUrl) async {
    await _close();
    await _openUri(redirectUrl);

    final state = redirectUrl.queryParameters['state'];
    final completer = Completer<Uri>();
    final httpServer = _httpServer = await HttpServer.bind(
      InternetAddress.loopbackIPv6,
      config.httpServerPort,
      shared: true,
    );

    final streamSubscription = _streamSubscription = httpServer.listen(
      (event) async {
        final qstate = event.uri.queryParameters['state'];
        if (state == null || state == qstate) {
          final html = await rootBundle.loadString(_htmlPath);
          event.response.headers.contentType = ContentType.html;
          event.response.write(html);
          await event.response.close();
          completer.complete(event.uri);
        } else {
          event.response.statusCode = HttpStatus.badRequest;
          await event.response.close();
        }
      },
      onDone: () {
        completer.completeError(
          CancelAuthorization('ListenRedirectUriForWindowsPlatform listen end'),
        );
      },
      onError: (dynamic err) {
        completer.completeError(CancelAuthorization(err));
      },
      cancelOnError: true,
    );

    return completer.future.whenComplete(() async {
      await streamSubscription.cancel();
      _streamSubscription = null;
      await httpServer.close(force: true);
      _httpServer = null;
    });
  }
}
