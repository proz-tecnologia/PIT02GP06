import 'package:flutter/cupertino.dart';

typedef ValidatorType = String? Function(String?);

class TextFieldItem {
  TextFieldItem({
    this.label,
    this.keyboardType,
    this.validator,
  });

  final controller = TextEditingController();
  final String? label;
  final TextInputType? keyboardType;
  final ValidatorType? validator;
}
