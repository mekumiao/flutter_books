import 'package:api/api.dart';

class MockVersionApi extends VersionApi {
  const MockVersionApi();

  @override
  Future<VersionDto?> latest() async {
    return const VersionDto(
      id: '1',
      versionCode: 1000,
      versionName: '测试更新',
      name: '',
      remark: '',
      url: '',
    );
  }
}
