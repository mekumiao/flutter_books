import 'dart:math';

import 'package:helper/src/date_helper.dart';
import 'package:intl/intl.dart';

class FormatHelper {
  const FormatHelper._();

  /// 格式化价格
  static String price(num price) {
    final oCcy = NumberFormat('#,##0.00', 'en_US');
    return oCcy.format(price);
  }

  /// 格式化时间戳(秒级时间戳)
  static String timestamp(String? timestamp) {
    if (timestamp != null && timestamp.isNotEmpty) {
      final seconds = int.tryParse(timestamp);
      if (seconds != null) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
        return DateHelper.apiDayFormat(dateTime);
      }
    }
    return '--';
  }

  /// 格式化时间戳(毫秒级时间戳)
  static String timestampMS(String? timestamp) {
    if (timestamp != null && timestamp.isNotEmpty) {
      final seconds = int.tryParse(timestamp);
      if (seconds != null) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(seconds);
        return DateHelper.apiDayFormat(dateTime);
      }
    }
    return '--';
  }

  /// 数量 K,M,B 格式化
  static String numberKMB(int num) {
    if (num > 999 && num < 99999) {
      return '${(num / 1000).toStringAsFixed(1)} K';
    } else if (num > 99999 && num < 999999) {
      return '${(num / 1000).toStringAsFixed(0)} K';
    } else if (num > 999999 && num < 999999999) {
      return '${(num / 1000000).toStringAsFixed(1)} M';
    } else if (num > 999999999) {
      return '${(num / 1000000000).toStringAsFixed(1)} B';
    } else {
      return num.toString();
    }
  }

  /// 渲染count
  static String renderCount(int count) {
    if (count <= 0) return '$count';
    final unitArr = ['', 'K', 'M', 'B'];
    final index = (log(count) / log(1000)).floor();
    var value = count.toString();
    if (index != 0) {
      value = (count / pow(1000, index)).toStringAsFixed(2);
    }
    return '$value${unitArr[index]}';
  }

  /// 渲染size
  static String renderSize(int size, {int unit = 1024}) {
    if (size <= 0 || unit <= 0) return '${size}Bytes';
    final unitArr = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final index = (log(size) / log(unit)).floor();
    var value = size.toString();
    if (index != 0) {
      value = (size / pow(unit, index)).toStringAsFixed(2);
    }
    return '$value${unitArr[index]}';
  }

  static String renderSizeForAndroid(int size) => renderSize(size, unit: 1000);
}
