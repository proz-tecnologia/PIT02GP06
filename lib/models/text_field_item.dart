import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

typedef ValidatorType = String? Function(String?);

class TextFieldItem {
  TextFieldItem(
      {this.label,
      this.icon,
      this.keyboardType,
      this.validator,
      this.formatter,
      this.isPassword = false});

  final controller = TextEditingController();
  final String? label;
  final IconData? icon;
  final TextInputType? keyboardType;
  final ValidatorType? validator;
  final List<TextInputFormatter>? formatter;
  final bool isPassword;
}
