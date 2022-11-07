import 'dart:async';

import 'package:authentication_repository/src/base_authentiction.dart';
import 'package:authentication_repository/src/id4/id4_onfig.dart';
import 'package:diagnose_logger/diagnose_logger.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';

class Id4OfflineAccessProvider extends OfflineAccessProvider {
  Id4OfflineAccessProvider();

  factory Id4OfflineAccessProvider.standard() => Id4OfflineAccessProvider();

  @override
  Future<Credentials?> refreshToken(Credentials credentials) async {
    final client = http.Client();
    try {
      final cre = await credentials.refresh(
        identifier: clientId,
        secret: clientSecret,
        httpClient: client,
      );
      return cre;
    } catch (e) {
      Log.logger.e('刷新token时发生异常', e);
    } finally {
      client.close();
    }
    return null;
  }

  @override
  FutureOr<void> revocationToken(Credentials credentials) async {
    final client = http.Client();

    /// 撤销 refresh_token
    if (credentials.refreshToken?.isNotEmpty ?? false) {
      try {
        await client.post(
          revocationEndpoint,
          body: {
            'client_id': clientId,
            'client_secret': clientSecret,
            'token': credentials.refreshToken,
            'token_type_hint': 'refresh_token',
          },
        );
      } catch (e) {
        Log.logger.e('撤销 refresh_token 时发生异常', e);
      }
    }

    /// 撤销 access_token。只有 reference 类型的 token 支持撤销
    if (credentials.accessToken.isNotEmpty == true &&
        !credentials.accessToken.contains('.')) {
      try {
        await client.post(
          revocationEndpoint,
          body: {
            'client_id': clientId,
            'client_secret': clientSecret,
            'token': credentials.accessToken,
            'token_type_hint': 'access_token',
          },
        );
      } catch (e) {
        Log.logger.e('撤销 access_token 时发生异常', e);
      }
    }

    client.close();
  }
}
