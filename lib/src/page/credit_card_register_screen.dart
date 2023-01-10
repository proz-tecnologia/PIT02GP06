import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/src/common/masks.dart';
import 'package:pit02gp06/src/page/view_model/credit_card_register_view_model.dart';
import 'package:pit02gp06/src/widgets/text_field_widget.dart';

class CreditCardRegisterScreen extends StatefulWidget {
  const CreditCardRegisterScreen({
    super.key,
    required this.viewModel,
    required this.onRegister,
  });

  final CreditCardRegisterViewModel viewModel;
  final Function(CreditCardModel) onRegister;

  @override
  State<CreditCardRegisterScreen> createState() =>
      _CreditCardRegisterScreenState();
}

class _CreditCardRegisterScreenState extends State<CreditCardRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final String nicknameKey = 'nickname';
  final String flagKey = 'flag';
  final String limitKey = 'limit';
  final String spentKey = 'spent';
  final String closeDateKey = 'close_date';
  final String dueDateKey = 'due_date';

  String? _validatorWhenEmpty(String? value, String validator) =>
      value != null && value.isEmpty ? validator : null;

  Map<String, TextFieldItem> _textFieldItemsMap(
      CreditCardRegisterViewModel vm) {
    return {
      nicknameKey: TextFieldItem(
          label: vm.nicknameLabel,
          validator: (value) => _validatorWhenEmpty(value, vm.nicknameLabel)),
      flagKey: TextFieldItem(
          label: vm.flagLabel,
          validator: (value) =>
              _validatorWhenEmpty(value, vm.flagValidatorText)),
      limitKey: TextFieldItem(
          label: vm.limitLabel,
          keyboardType: TextInputType.number,
          validator: (value) =>
              _validatorWhenEmpty(value, vm.genericValueValidatorText)),
      spentKey: TextFieldItem(
          label: vm.spentLabel,
          keyboardType: TextInputType.number,
          validator: (value) =>
              _validatorWhenEmpty(value, vm.genericValueValidatorText)),
      closeDateKey: TextFieldItem(
          label: vm.closeDateLabel,
          keyboardType: TextInputType.datetime,
          formatter: [dayMask],
          validator: (value) =>
              _validatorWhenEmpty(value, vm.genericDateValidatorText)),
      dueDateKey: TextFieldItem(
          label: vm.dueDateLabel,
          keyboardType: TextInputType.datetime,
          formatter: [dayMask],
          validator: (value) =>
              _validatorWhenEmpty(value, vm.genericDateValidatorText)),
    };
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    final textFieldItemsMap = _textFieldItemsMap(vm);

    if (widget.viewModel.model != null) _fillValues(textFieldItemsMap);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(vm.model == null ? vm.registerTitle : vm.editTitle),
        centerTitle: true,
        actions: [
          CloseButton(
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Image.asset(
                'lib/images/credit_card.png',
                height: 100,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(item: textFieldItemsMap[nicknameKey]),
              TextFieldWidget(item: textFieldItemsMap[flagKey]),
              TextFieldWidget(item: textFieldItemsMap[limitKey]),
              TextFieldWidget(item: textFieldItemsMap[spentKey]),
              TextFieldWidget(item: textFieldItemsMap[closeDateKey]),
              TextFieldWidget(item: textFieldItemsMap[dueDateKey]),
              const SizedBox(height: 10),
              MaterialButton(
                color: Colors.indigoAccent,
                onPressed: () => _register(textFieldItemsMap),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    vm.model == null ? vm.registerButton : vm.editButton,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _fillValues(Map<String, TextFieldItem> map) {
    map[nicknameKey]?.controller.text = widget.viewModel.model?.nickname ?? '';
    map[flagKey]?.controller.text = widget.viewModel.model?.flag ?? '';
    map[limitKey]?.controller.text =
        widget.viewModel.model?.limit.toString() ?? '';
    map[spentKey]?.controller.text =
        widget.viewModel.model?.spent.toString() ?? '';
  }

  void _register(Map<String, TextFieldItem> map) {
    if (!(_formKey.currentState?.validate() ?? true)) return;
    try {
      var inputFormat = DateFormat('dd');
      final creditCardModel = CreditCardModel(
          accountId: "0",
          flag: map[flagKey]!.controller.text,
          nickname: map[nicknameKey]!.controller.text,
          limit: double.parse(map[limitKey]!.controller.text),
          spent: double.parse(map[spentKey]!.controller.text),
          closeDate: inputFormat.parse(map[closeDateKey]!.controller.text),
          dueDate: inputFormat.parse(map[dueDateKey]!.controller.text));
      widget.onRegister(creditCardModel);
    } catch (e) {
      print('erro nos dados = $e');
    }
  }
}
