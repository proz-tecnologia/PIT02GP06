import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/src/common/masks.dart';
import 'package:pit02gp06/src/page/view_model/credit_card_register_view_model.dart';
import 'package:pit02gp06/src/widgets/show_loading_dialog.dart';
import 'package:pit02gp06/src/widgets/text_field_widget.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../authentication_module/auth_repository.dart';

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
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.grey1Color,
        shadowColor: Color.fromARGB(40, 0, 0, 0),
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(20, 20))),
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
          padding: const EdgeInsets.fromLTRB(45, 30, 45, 30),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Image.asset(
                'lib/images/credit_card.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                item: textFieldItemsMap[nicknameKey],
                borderColor: AppColors.grey1Color,
              ),
              TextFieldWidget(
                item: textFieldItemsMap[flagKey],
                borderColor: AppColors.grey1Color,
              ),
              TextFieldWidget(
                item: textFieldItemsMap[limitKey],
                borderColor: AppColors.grey1Color,
              ),
              TextFieldWidget(
                item: textFieldItemsMap[spentKey],
                borderColor: AppColors.grey1Color,
              ),
              TextFieldWidget(
                item: textFieldItemsMap[closeDateKey],
                borderColor: AppColors.grey1Color,
              ),
              TextFieldWidget(
                item: textFieldItemsMap[dueDateKey],
                borderColor: AppColors.grey1Color,
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: AppColors.secondaryColor,
                onPressed: () => _register(textFieldItemsMap),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    vm.model == null ? vm.registerButton : vm.editButton,
                    style: AppTextStyles.textRegisterCard,
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

  void _register(Map<String, TextFieldItem> map) async {
    if (!(_formKey.currentState?.validate() ?? true)) return;
    try {
      showLoadingDialog(context);
      final user = await Modular.get<AuthRepository>().getUser();

      var inputFormat = DateFormat('dd');
      final creditCardModel = CreditCardModel(
          uid: user.uid,
          flag: map[flagKey]!.controller.text,
          nickname: map[nicknameKey]!.controller.text,
          limit: double.parse(map[limitKey]!.controller.text),
          spent: double.parse(map[spentKey]!.controller.text),
          closeDate: inputFormat.parse(map[closeDateKey]!.controller.text),
          dueDate: inputFormat.parse(map[dueDateKey]!.controller.text));
      widget.onRegister(creditCardModel);
      Modular.to.pop(); //fechar LoadingDialog
      Modular.to.pop();
    } catch (e) {
      log('erro nos dados = $e');
    }
  }
}