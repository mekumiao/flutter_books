import 'package:flutter/material.dart';
import 'package:general_widgets/src/dialogs/base_dialog.dart';
import 'package:helper/helper.dart';
import 'package:input_formatter/input_formatter.dart';

/// 数量弹窗输入
class QuantityInputDialog extends StatefulWidget {
  const QuantityInputDialog({
    super.key,
    this.title,
    this.defaultValue,
    this.inputMax = 100,
    required this.onPressed,
  });

  final String? title;
  final int inputMax;
  final int? defaultValue;
  final void Function(int?) onPressed;

  @override
  QuantityInputDialogState createState() => QuantityInputDialogState();
}

class QuantityInputDialogState extends State<QuantityInputDialog> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      _controller.text = widget.defaultValue.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        height: 34,
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        decoration: BoxDecoration(
          color: ThemeHelper.getDialogTextFieldColor(context),
          borderRadius: BorderRadius.circular(2),
        ),
        child: TextField(
          key: const Key('quantity_input'),
          autofocus: true,
          controller: _controller,
          //style: TextStyles.textDark14,
          keyboardType: TextInputType.number,
          inputFormatters: [
            UsNumberTextInputFormatter(
              digit: 0,
              max: widget.inputMax.toDouble(),
            )
          ],
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: InputBorder.none,
            hintText: '输入${widget.title}',
            //hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).maybePop();
        final v = int.tryParse(_controller.text);
        widget.onPressed(v);
      },
    );
  }
}
