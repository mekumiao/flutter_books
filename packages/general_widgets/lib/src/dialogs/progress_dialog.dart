import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:general_data/general_data.dart';

/// 加载中的弹框
class ProgressDialog extends Dialog {
  const ProgressDialog({
    super.key,
    this.hintText = '',
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 88,
          width: 120,
          decoration: const ShapeDecoration(
            color: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: ThemeData(
                  cupertinoOverrideTheme: const CupertinoThemeData(
                    // 局部指定夜间模式，加载圈颜色会设置为白色
                    brightness: Brightness.dark,
                  ),
                ),
                child: const CupertinoActivityIndicator(radius: 14),
              ),
              Gaps.vGap8,
              Text(
                hintText,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
