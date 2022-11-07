import 'package:flutter/material.dart';
import 'package:general_data/general_data.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    this.onTap,
    required this.title,
    this.content,
    this.textAlign = TextAlign.end,
    this.maxLines,
    this.overflow,
  });

  final GestureTapCallback? onTap;
  final String title;
  final String? content;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      children: <Widget>[
        Text(title),
        const Spacer(),
        Gaps.hGap16,
        Expanded(
          flex: 4,
          child: Text(
            content ?? '',
            maxLines: maxLines,
            textAlign: textAlign,
            overflow: overflow,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontSize: Dimens.font_sp14),
          ),
        ),
        Gaps.hGap8,
        Opacity(
          // 无点击事件时，隐藏箭头图标
          opacity: onTap == null ? 0 : 1,
          child: Padding(
            padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
            child: Image.asset(
              'assets/ic_arrow_right.png',
              height: 16,
              width: 16,
              package: 'general_widgets',
            ),
          ),
        )
      ],
    );

    /// 分隔线
    child = Container(
      margin: const EdgeInsets.only(left: 15),
      padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        ),
      ),
      child: child,
    );

    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}
