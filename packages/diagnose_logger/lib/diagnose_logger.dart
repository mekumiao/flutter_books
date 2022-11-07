library diagnose_logger;

import 'package:environment_variable/environment_variable.dart';
import 'package:logger/logger.dart';

class Log {
  const Log._();

  static Logger? _logger;
  static Logger get logger =>
      _logger ??
      Logger(
        level: Env.isProduction
            ? Level.warning
            : Env.isDevelopment
                ? Level.debug
                : Level.info,
      );
}
