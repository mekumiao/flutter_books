import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:api/api.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/app/app.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:diagnose_logger/diagnose_logger.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:helper/helper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_size/window_size.dart';

Future<void> bootstrap({
  required VersionApi versionApi,
  required AuthenticationRepository authenticationRepository,
  required ConfigurationRepository configurationRepository,
  required AdaptResultCallback adaptResultCallback,
}) async {
  setupWindow();

  FlutterError.onError = _onFlutterError;
  PlatformDispatcher.instance.onError = _onPlatformDispatcherError;
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await _hydratedStorageBuild();
  EasyRefresh.defaultHeaderBuilder = ClassicHeader.new;
  EasyRefresh.defaultFooterBuilder = ClassicFooter.new;

  runApp(
    App(
      versionApi: versionApi,
      authenticationRepository: authenticationRepository,
      configurationRepository: configurationRepository,
      adaptResultCallback: adaptResultCallback,
    ),
  );
}

void setupWindow() {
  const windowWidth = 480.0;
  const windowHeight = 854.0;
  if (Device.isDesktop) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(
        Rect.fromCenter(
          center: screen!.frame.center,
          width: windowWidth,
          height: windowHeight,
        ),
      );
    });
  }
}

HydratedAesCipher _encryptionCipher() {
  const password = 'M.=8ZApsH)M=lx#q_Xv6';
  final byteskey = sha256.convert(utf8.encode(password)).bytes;
  return HydratedAesCipher(byteskey);
}

Future<Storage> _hydratedStorageBuild() async {
  return HydratedStorage.build(
    encryptionCipher: _encryptionCipher(),
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
}

void _onFlutterError(FlutterErrorDetails details) {
  FlutterError.presentError(details);
  if (kReleaseMode) exit(1);
}

bool _onPlatformDispatcherError(Object error, StackTrace stack) {
  Log.logger.e('error: FlutterError', error, stack);
  return true;
}
