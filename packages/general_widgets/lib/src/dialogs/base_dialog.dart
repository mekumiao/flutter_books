import 'dart:io';

import 'package:flutter/material.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/src/l10n/general_localizations.dart';
import 'package:helper/helper.dart';

/// 自定义dialog的模板
class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    this.title,
    this.onPressed,
    this.hiddenTitle = false,
    required this.child,
  });

  final String? title;
  final VoidCallback? onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    final Widget dialogTitle = Visibility(
      visible: !hiddenTitle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          hiddenTitle ? '' : title ?? context.generaltr.tips,
          style: TextStyles.textBold18,
        ),
      ),
    );

    final Widget bottomButton = Row(
      children: <Widget>[
        DialogButton(
          text: context.generaltr.cancel,
          onPressed: () => Navigator.maybePop(context),
        ),
        const SizedBox(
          height: 48,
          width: 0.6,
          child: VerticalDivider(),
        ),
        DialogButton(
          text: context.generaltr.confirm,
          textColor: Theme.of(context).primaryColor,
          onPressed: onPressed,
        ),
      ],
    );

    final Widget content = Material(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap24,
          dialogTitle,
          Flexible(child: child),
          Gaps.vGap8,
          Gaps.line,
          bottomButton,
        ],
      ),
    );

    final Widget body = MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Center(
        child: SizedBox(
          width: 270,
          child: content,
        ),
      ),
    );

    /// Android 11添加了键盘弹出动画，这与我添加的过渡动画冲突（原先iOS、Android 没有相关过渡动画，相关问题跟踪：https://github.com/flutter/flutter/issues/19279）。
    /// 因为在Android 11上，viewInsets的值在键盘弹出过程中是变化的（以前只有开始结束的值）。
    /// 所以解决方法就是在Android 11及以上系统中使用Padding代替AnimatedPadding。
    if (Platform.isAndroid &&
        Device.androidInfo.version.sdkInt != null &&
        Device.androidInfo.version.sdkInt! >= 30) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: body,
      );
    } else {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: body,
      );
    }
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.text,
    this.textColor,
    this.onPressed,
  });

  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
