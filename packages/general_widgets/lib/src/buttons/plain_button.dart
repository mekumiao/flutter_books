import 'package:flutter/material.dart';

class PlainButton extends StatelessWidget {
  const PlainButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
