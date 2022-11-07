import 'dart:async';

import 'package:authentication_repository/src/base_authentiction.dart';
import 'package:diagnose_logger/diagnose_logger.dart';
import 'package:oauth2/oauth2.dart';

class MockOfflineAccessProvider extends OfflineAccessProvider {
  MockOfflineAccessProvider();

  factory MockOfflineAccessProvider.standard() {
    return MockOfflineAccessProvider();
  }

  @override
  Future<Credentials?> refreshToken(Credentials credentials) async {
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
  FutureOr<void> revocationToken(Credentials credentials) async {
    Log.logger.d('调用撤销token方法');
  }
}
