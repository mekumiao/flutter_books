import 'package:flutter_test/flutter_test.dart';
import 'package:helper/helper.dart';

void main() {
  group('renderSize', () {
    const utBytes = 1;
    const utKB = 1024;
    const utMB = 1024 * 1024;
    const utGB = 1024 * 1024 * 1024;
    const utTB = 1024 * 1024 * 1024 * 1024;

    test('renderSize Bytes', () {
      expect(FormatHelper.renderSize(512 * utBytes), '512Bytes');
      expect(FormatHelper.renderSize(689 * utBytes), '689Bytes');
    });

    test('renderSize KB', () {
      expect(
        FormatHelper.renderSize(512 * utKB + (0.6 * utKB).floor()),
        '512.60KB',
      );
      expect(
        FormatHelper.renderSize(689 * utKB + (0.43 * utKB).floor()),
        '689.43KB',
      );
    });

    test('renderSize MB', () {
      expect(
        FormatHelper.renderSize(512 * utMB + (0.6 * utMB).floor()),
        '512.60MB',
      );
      expect(
        FormatHelper.renderSize(689 * utMB + (0.43 * utMB).floor()),
        '689.43MB',
      );
    });

    test('renderSize GB', () {
      expect(
        FormatHelper.renderSize(512 * utGB + (0.6 * utGB).floor()),
        '512.60GB',
      );
      expect(
        FormatHelper.renderSize(689 * utGB + (0.43 * utGB).floor()),
        '689.43GB',
      );
    });

    test('renderSize TB', () {
      expect(
        FormatHelper.renderSize(512 * utTB + (0.6 * utTB).floor()),
        '512.60TB',
      );
      expect(
        FormatHelper.renderSize(689 * utTB + (0.43 * utTB).floor()),
        '689.43TB',
      );
    });
  });
}
