import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  String text;
  TextStyle style;
  ButtonSecondary({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          onPressed: () {},
          child: Text(
            text,
            style: style,
          )),
    );
  }
}
