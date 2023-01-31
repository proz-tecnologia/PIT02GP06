// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:pit02gp06/models/user_model.dart';

import '../../../models/text_field_item.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../widgets/text_field_widget.dart';
import 'user_controller.dart';

class FormUserWidget extends StatefulWidget {
  final UserModel user;
  const FormUserWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<FormUserWidget> createState() => _FormUserWidgetState();
}

class _FormUserWidgetState extends State<FormUserWidget> {
  final _controller = Modular.get<UserController>();
  final nameItem = TextFieldItem(
    label: 'Nome Completo',
  );
  final phoneItem = TextFieldItem(label: 'Telefone');
  final dropValue = ValueNotifier('');
  final dropOptions = ['Feminino', 'Masculino', 'Não informado'];
  DateTime? _dateTime;
  @override
  void initState() {
    nameItem.controller.text = widget.user.name ?? '';
    phoneItem.controller.text = widget.user.phone ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TEXT "MEUS DADOS"
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Meus dados',
            style: AppTextStyles.textButtonSecondaryBlue,
          ),
        ),
        Divider(
          color: AppColors.secondaryColor,
          thickness: 0.5,
        ),
        const SizedBox(height: 10),
        // INPUT FULL NAME
        TextFieldWidget(
          item: nameItem,
          borderColor: AppColors.grey2Color,
        ),
        // DATE
        Container(
          height: 58,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.grey2Color),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _dateTime == null
                      ? 'Data de Nascimento'
                      : _dateTime.toString(),
                  style: AppTextStyles.textFieldProfileScreen,
                ),
                IconButton(
                    color: AppColors.grey3Color,
                    iconSize: 30,
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2222))
                          .then((date) {
                        setState(() {
                          _dateTime = date!;
                        });
                      });
                    },
                    icon: const Icon(Icons.calendar_month)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // PHONE
        TextFieldWidget(
          item: phoneItem,
          borderColor: AppColors.grey2Color,
        ),
        // GENDER
        ValueListenableBuilder(
            valueListenable: dropValue,
            builder: (BuildContext context, String value, _) {
              return SizedBox(
                width: 290,
                height: 58,
                child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    hint: const Text('Gênero'),
                    value: (value.isEmpty) ? null : value,
                    onChanged: (choice) => dropValue.value = choice.toString(),
                    items: dropOptions
                        .map((op) => DropdownMenuItem(
                              value: op,
                              child: Text(
                                op,
                                style: AppTextStyles.textFieldProfileScreen,
                              ),
                            ))
                        .toList()),
              );
            }),
        const SizedBox(height: 10),
        // BUTTON "SALVAR"
        ElevatedButton(
          onPressed: () {
            widget.user.name = nameItem.controller.text;
            widget.user.phone = phoneItem.controller.text;
            _controller.save(widget.user);
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(290, 50),
              padding: const EdgeInsets.all(18),
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Text(
            "Salvar",
            style: AppTextStyles.textButtonWidget,
          ),
        ),
      ],
    );
  }
}
