import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/bootstrap.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:environment_variable/environment_variable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helper/helper.dart';
import 'package:mock_api/mock_api.dart';

Future<void> main() async {
  Env.staging();
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await SpUtil.getInstance();
  await Device.ensureInitialized();

  await bootstrap(
    versionApi: const MockVersionApi(),
    authenticationRepository: AuthenticationRepository.mock(),
    configurationRepository: ConfigurationRepository.memoryStore(),
    adaptResultCallback: AdaptToken.none,
  );
}
