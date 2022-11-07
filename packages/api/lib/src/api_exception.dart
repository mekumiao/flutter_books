import 'package:api/src/models/output_result.dart';

class FetchException implements Exception {
  FetchException(this.message, [this.error]);

  final String message;
  final dynamic error;
}

class InvalidCodeException implements Exception {
  InvalidCodeException(this.code, this.message, [this.error]);

  factory InvalidCodeException.fromOutputResult(OutputResult outputResult) {
    return InvalidCodeException(
      outputResult.code,
      outputResult.message,
      outputResult,
    );
  }

  final int code;
  final String message;
  final OutputResult? error;
}
