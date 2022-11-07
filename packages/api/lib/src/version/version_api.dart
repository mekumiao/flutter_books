import 'package:api/src/api_exception.dart';
import 'package:api/src/version/models/models.dart';

class VersionRequestFailure extends FetchException {
  VersionRequestFailure(super.message, [super.error]);
}

abstract class VersionApi {
  const VersionApi();

  /// 获取最新版信息
  ///
  /// 请求失败、状态码!=200、返回数据格式错误、code!=0时，
  /// 将抛出 `VersionRequestFailure` 异常
  Future<VersionDto?> latest();
}
