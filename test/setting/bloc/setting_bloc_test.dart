import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/setting/setting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  group('SettingBloc', () {
    test('initial state is initial when user is empty', () {
      expect(
        SettingBloc().state,
        const SettingState(),
      );
    });

    group('VersionLoaded', () {
      setUp(() {
        PackageInfo.setMockInitialValues(
          appName: 'appName',
          packageName: 'packageName',
          version: 'version',
          buildNumber: 'buildNumber',
          buildSignature: 'buildSignature',
          installerStore: 'installerStore',
        );
      });

      blocTest<SettingBloc, SettingState>(
        'invokes refreshToken',
        setUp: () {},
        build: SettingBloc.new,
        act: (bloc) => bloc.add(VersionLoaded()),
        expect: () => [
          const SettingState(verison: 'version'),
        ],
      );
    });
  });
}
