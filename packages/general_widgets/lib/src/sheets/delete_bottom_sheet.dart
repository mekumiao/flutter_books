import 'package:flutter/material.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';

class DeleteBottomSheet extends StatelessWidget {
  const DeleteBottomSheet({
    super.key,
    required this.onTapDelete,
  });

  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 52,
              child: Center(
                child: Text(
                  context.generaltr.askDelete,
                  style: TextStyles.textSize16,
                ),
              ),
            ),
            Gaps.line,
            MyButton(
              minHeight: 54,
              textColor: Theme.of(context).errorColor,
              text: context.generaltr.confirm,
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).maybePop();
                onTapDelete();
              },
            ),
            Gaps.line,
            MyButton(
              minHeight: 54,
              textColor: Colours.text_gray,
              text: context.generaltr.cancel,
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
