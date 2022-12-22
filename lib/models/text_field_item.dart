import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

typedef ValidatorType = String? Function(String?);

class TextFieldItem {
  TextFieldItem(
      {this.label, this.keyboardType, this.validator, this.formatter});

  final controller = TextEditingController();
  final String? label;
  final TextInputType? keyboardType;
  final ValidatorType? validator;
  final List<TextInputFormatter>? formatter;
}
