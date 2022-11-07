import 'dart:convert';

import 'package:authentication_repository/src/base_authentiction.dart';
import 'package:authentication_repository/src/id4/id4_onfig.dart' as config;
import 'package:authentication_repository/src/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';

class Id4PasswordGrantProvider extends PasswordGrantProvider {
  Id4PasswordGrantProvider({
    required this.clientId,
    required this.clientSecret,
    required this.tokenEndpoint,
    required this.scopes,
    required this.userinfoEndpoint,
  });

  factory Id4PasswordGrantProvider.standard() {
    return Id4PasswordGrantProvider(
      clientId: config.clientId,
      clientSecret: config.clientSecret,
      tokenEndpoint: config.tokenEndpoint,
      scopes: config.scopes,
      userinfoEndpoint: config.userinfoEndpoint,
    );
  }

  final String clientId;
  final String clientSecret;
  final Uri userinfoEndpoint;
  final Uri tokenEndpoint;
  final List<Scope> scopes;

  Client? _client;
  Userinfo? _userinfo;

  @override
  Userinfo get userinfo {
    if (_userinfo != null) return _userinfo!;
    throw Exception('没有获取userinfo信息');
  }

  @override
  Future<void> handleResourceOwnerPassword(
    String email,
    String password,
  ) async {
    final httpClient = http.Client();
    final client = await resourceOwnerPasswordGrant(
      tokenEndpoint,
      email,
      password,
      basicAuth: false,
      httpClient: httpClient,
      identifier: clientId,
      secret: clientSecret,
      scopes: scopes.map((e) => e.name),
    ).timeout(const Duration(seconds: 10));
    final resultScopes = client.credentials.scopes;
    if (resultScopes == null) throw Exception('没有授予任何权限');
    if (scopes
        .where((e) => e.isRequired)
        .map((e) => e.name)
        .every(resultScopes.contains)) {
      _client = client;
      return;
    }
    throw Exception('使用密码模式认证失败');
  }

  @override
  Future<void> handleUserinfo() async {
    if (_client != null) {
      final resp = await _client!.get(userinfoEndpoint);
      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.body) as Map<String, dynamic>;
        _userinfo = Userinfo.fromJson(json);
        return;
      }
    }
    throw Exception('获取用户信息失败');
  }

  @override
  Credentials get credentials {
    if (_client?.credentials != null) return _client!.credentials;
    throw Exception('_client is null');
  }

  @override
  void clear() {
    _client?.close();
    _client = null;
    _userinfo = null;
  }
}
