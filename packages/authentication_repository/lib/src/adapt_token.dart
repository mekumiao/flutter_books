import 'package:authentication_repository/src/adapter_result.dart';

typedef AdaptResultCallback = AdaptResult Function(String? token);

class AdaptToken {
  const AdaptToken._();

  /// 不适配token
  ///
  /// 一般用于演示环境
  static const AdaptResultCallback none = _none;

  /// 令牌模式
  ///
  /// 一般用于开发环境
  static const AdaptResultCallback token = _token;

  /// 票据模式
  ///
  /// 一般用于正式环境
  static const AdaptResultCallback bearer = _bearer;

  static AdaptResult _none(String? token) {
    return const AdaptResult(
      headers: {},
      queryParameters: {},
    );
  }

  static AdaptResult _token(String? token) {
    return AdaptResult(
      headers: {'token': token},
      queryParameters: {'token': token},
    );
  }

  static AdaptResult _bearer(String? token) {
    return AdaptResult(
      headers: {'Authorization': 'Bearer $token'},
      queryParameters: {},
    );
  }
}
