import 'dart:math';

/// 随机字符、数字工具类。帮助生成随机字符或者数字
class RandomHelper {
  const RandomHelper._();

  static String generateRandomString([int length = 20]) {
    assert(length > 0, 'length must be greater than 0');
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(
      length,
      (index) => availableChars[random.nextInt(availableChars.length)],
    ).join();
    return randomString;
  }
}
