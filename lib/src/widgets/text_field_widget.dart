import 'package:flutter/material.dart';
import 'package:pit02gp06/models/text_field_item.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, this.item});

  final TextFieldItem? item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          keyboardType: item?.keyboardType ?? TextInputType.text,
          controller: item?.controller,
          validator: item?.validator ??
              (String? value) {
                return value != null && value.isEmpty
                    ? "Digite um valor"
                    : null;
              },
          inputFormatters: item?.formatter,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: item?.label,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
