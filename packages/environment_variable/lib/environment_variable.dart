library environment_variable;

import 'package:flutter/foundation.dart';

class Env {
  Env._();

  static const _pro = 'production';
  static const _dev = 'development';
  static const _stg = 'staging';

  static String? _env;
  static Uri? _baseUrl;
  static int? _connectTimeout;
  static int? _receiveTimeout;

  static bool get isDevelopment => _env == _dev;
  static bool get isStaging => _env == _stg;
  static bool get isProduction =>
      _env == _pro || (!isDevelopment && !isStaging);

  static Uri get baseUrl {
    if (_baseUrl == null) throw Exception('_baseUrl is null');
    return _baseUrl!;
  }

  static int? get connectTimeout => _connectTimeout;

  static int? get receiveTimeout => _receiveTimeout;

  static void production() {
    _env = _pro;
    _baseUrl = Uri.parse('https://forwordtpl.tk/books/api');
    _connectTimeout = kIsWeb ? 0 : 5 * 1000;
    _receiveTimeout = 20 * 1000;
  }

  static void development() {
    _env = _dev;
    _baseUrl = Uri.parse('https://localhost/books/api');
    _connectTimeout = kIsWeb ? 0 : 5 * 1000;
    _receiveTimeout = null;
  }

  static void staging() {
    _env = _stg;
  }
}
