import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  final String text;
  final TextStyle style;
  const ButtonSecondary({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: style,
        ));
  }
}
