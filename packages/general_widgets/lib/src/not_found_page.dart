import 'package:flutter/material.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';
import 'package:helper/helper.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    super.key,
    this.title,
  });

  final String? title;

  static Route<void> route({String? title}) {
    return MaterialPageRoute<void>(
      builder: (settings) => NotFoundPage(title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: title ?? context.generaltr.notfound,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
            opacity: context.isDark ? 0.5 : 1,
            child: Image.asset(
              'assets/ic_not_found.png',
              width: 120,
              package: 'general_widgets',
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: Dimens.gap_dp16,
          ),
          Text(
            context.generaltr.notfound,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontSize: Dimens.font_sp14),
          ),
          Gaps.vGap50,
        ],
      ),
    );
  }
}
