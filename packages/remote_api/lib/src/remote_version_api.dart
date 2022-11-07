import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:remote_api/src/response_extension.dart';

class RemoteVersionApi implements VersionApi {
  const RemoteVersionApi({required Dio unauth}) : _unauth = unauth;

  final Dio _unauth;

  @override
  Future<VersionDto?> latest() async {
    try {
      final resp = await _unauth.get<dynamic>('version/latest');
      final result = resp.toResult<Map<String, dynamic>>();
      return VersionDto.fromJson(result);
    } on InvalidCodeException catch (e) {
      throw VersionRequestFailure(e.message, e.error);
    } on FetchException catch (e) {
      throw VersionRequestFailure(e.message, e.error);
    } on DioError catch (e) {
      throw VersionRequestFailure(e.message, e.error);
    }
  }
}
