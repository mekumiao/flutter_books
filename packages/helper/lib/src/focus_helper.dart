import 'package:flutter/material.dart';

class FocusHelper {
  const FocusHelper._();

  /// 关闭键盘
  static void closeKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    /// 键盘是否是弹起状态
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
