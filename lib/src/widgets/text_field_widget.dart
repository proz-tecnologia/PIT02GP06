import 'package:flutter/material.dart';
import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, this.item});

  final TextFieldItem? item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          style: const TextStyle(fontSize: 13, fontFamily: "Karla"),
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
            filled: true,
            fillColor: AppColors.grey4Color,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
            prefixIcon: item?.icon != null
                ? Icon(
                    item?.icon,
                    size: 18,
                  )
                : null,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )),
            labelText: item?.label,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
