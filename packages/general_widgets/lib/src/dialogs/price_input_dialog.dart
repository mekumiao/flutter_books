import 'package:flutter/material.dart';
import 'package:general_widgets/src/dialogs/base_dialog.dart';
import 'package:input_formatter/input_formatter.dart';

class PriceInputDialog extends StatefulWidget {
  const PriceInputDialog({
    super.key,
    this.title,
    this.inputMaxPrice = 100000,
    required this.onPressed,
  });

  final String? title;
  final double inputMaxPrice;
  final void Function(String) onPressed;

  @override
  PriceInputDialogState createState() => PriceInputDialogState();
}

class PriceInputDialogState extends State<PriceInputDialog> {
  final TextEditingController _controller = TextEditingController();

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
          borderRadius: BorderRadius.circular(2),
        ),
        child: TextField(
          key: const Key('price_input'),
          autofocus: true,
          controller: _controller,
          //style: TextStyles.textDark14,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // 金额限制数字格式
          inputFormatters: [
            UsNumberTextInputFormatter(max: widget.inputMaxPrice)
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
        widget.onPressed(_controller.text);
      },
    );
  }
}
