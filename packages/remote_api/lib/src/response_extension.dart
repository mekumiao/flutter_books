import 'package:api/api.dart';
import 'package:diagnose_logger/diagnose_logger.dart';
import 'package:dio/dio.dart';

extension ResponseX on Response<dynamic> {
  /// 将结果转换为 `OutputResult` 类型
  ///
  /// 当 statusCode != 200 或者 data == null 时，将抛出 `FetchException` 异常
  OutputResult toOutputResult() {
    if (statusCode == 200 && data != null) {
      final json = data! as Map<String, dynamic>;
      return OutputResult.fromJson(json);
    }
    Log.logger.e('status code is not 200 or data is null.', this);
    throw FetchException('status code is not 200 or data is null.');
  }

  /// 将结果转换为指定类型
  ///
  /// 当 OutputResult.code != 0 时，将抛出 `InvalidCodeException` 异常
  T toResult<T>() {
    if (statusCode == 200 && data != null) {
      final json = data! as Map<String, dynamic>;
      final output = OutputResult.fromJson(json);
      if (output.code == 0) return output.result as T;
      throw InvalidCodeException.fromOutputResult(output);
    }
    Log.logger.e('status code is not 200 or data is null.', this);
    throw FetchException('status code is not 200 or data is null.');
  }
}
