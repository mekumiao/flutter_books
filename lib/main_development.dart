import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/bootstrap.dart';
import 'package:booksapp/http/api_dio.dart';
import 'package:booksapp/http/security_context_loader.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:environment_variable/environment_variable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helper/helper.dart';
import 'package:remote_api/remote_api.dart';
import 'package:sp_util/sp_util.dart';

Future<void> main() async {
  Env.development();
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await SpUtil.getInstance();
  await Device.ensureInitialized();
  await SecurityContextLoader.ensureInitialized();

  final authenticationRepository = AuthenticationRepository.mock();
  final configurationRepository = ConfigurationRepository.localStore();
  const adaptResultCallback = AdaptToken.token;

  final apiDio = ApiDio.single(
    authenticationRepository: authenticationRepository,
    adaptResultCallback: adaptResultCallback,
  );

  final versionApi = RemoteVersionApi(unauth: apiDio.unauth);

  await bootstrap(
    versionApi: versionApi,
    authenticationRepository: authenticationRepository,
    configurationRepository: configurationRepository,
    adaptResultCallback: adaptResultCallback,
  );
}
