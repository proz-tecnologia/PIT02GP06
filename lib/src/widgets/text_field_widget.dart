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
          obscureText: item?.isPassword ?? false,
          controller: item?.controller,
          validator: item?.validator ??
              (String? value) {
                return value != null && value.isEmpty
                    ? "Digite um valor"
                    : null;
              },
          inputFormatters: item?.formatter,
          decoration: InputDecoration(
            prefixIcon: item?.icon != null
                ? Icon(
                    item?.icon,
                    size: 18,
                  )
                : null,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(16),
            )),
            labelText: item?.label,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
