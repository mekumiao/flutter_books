import 'dart:async';

import 'package:authentication_repository/src/base_authentiction.dart';
import 'package:authentication_repository/src/models/userinfo.dart';
import 'package:oauth2/oauth2.dart';

class MockAuthorizationCodeGrantProvider
    extends AuthorizationCodeGrantProvider {
  MockAuthorizationCodeGrantProvider();

  factory MockAuthorizationCodeGrantProvider.standard() =>
      MockAuthorizationCodeGrantProvider();

  @override
  Credentials get credentials {
    return Credentials(
      '123123',
      refreshToken: '123123',
      idToken: '123123',
      tokenEndpoint: Uri.parse('https://localhost'),
      scopes: ['openid'],
      expiration: DateTime.now().add(const Duration(hours: 1)),
    );
  }

  @override
  Future<void> handleAuthorizationResponse(Uri responseUrl) async {}

  @override
  Future<Uri> handleResponseUrl() async {
    return Future.value(Uri.parse('https://localhost'));
  }

  @override
  Userinfo get userinfo => const Userinfo(sub: '1', name: 'name');

  @override
  void clear() {}

  @override
  Future<void> handleUserinfo() async {}
}
