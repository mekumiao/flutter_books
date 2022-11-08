import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_data/general_data.dart';
import 'package:helper/helper.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title = '',
    this.centerTitle = true,
    this.action,
    this.backImgColor,
    this.isShowBack = true,
  });

  final String title;
  final bool centerTitle;
  final Color? backImgColor;
  final ActionButton? action;
  final bool isShowBack;

  @override
  Widget build(BuildContext context) {
    final overlayStyle =
        ThemeData.estimateBrightnessForColor(context.backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: context.backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              TitleText(
                text: title,
                isCenter: centerTitle,
              ),
              if (isShowBack) const BackButton() else Gaps.empty,
              action ?? Gaps.empty,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
    this.isCenter = true,
  });

  final String text;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment: isCenter ? Alignment.center : Alignment.centerLeft,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 48),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: Dimens.font_sp18,
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final isBack = await Navigator.maybePop(context);
        if (!isBack) {
          await SystemNavigator.pop();
        }
      },
      tooltip: 'Back',
      padding: const EdgeInsets.all(12),
      icon: Image.asset(
        'assets/ic_arrow_left.png',
        package: 'general_widgets',
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.text,
    this.onPressed,
    this.child,
  });

  final String? text;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: const ButtonThemeData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            minWidth: 60,
          ),
        ),
        child: child ??
            ElevatedButton(
              onPressed: onPressed ?? () => {},
              child: Text(
                text ?? '',
                style: const TextStyle(fontSize: Dimens.font_sp14),
              ),
            ),
      ),
    );
  }
}
