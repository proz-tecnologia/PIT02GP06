import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/src/widgets/text_field_widget.dart';

class CreditCardRegisterScreen extends StatefulWidget {
  const CreditCardRegisterScreen({super.key, this.model});

  final CreditCardModel? model;

  @override
  State<CreditCardRegisterScreen> createState() =>
      _CreditCardRegisterScreenState();
}

class _CreditCardRegisterScreenState extends State<CreditCardRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nickname = TextFieldItem(
    label: "Apelido do cartão",
    validator: (value) =>
        value != null && value.isEmpty ? "Digite um apelido válido" : null,
  );

  final flag = TextFieldItem(
    label: "Bandeira",
    validator: (value) =>
        value != null && value.isEmpty ? "Digite uma bandeira válida" : null,
  );

  final limit = TextFieldItem(
    label: "Limite",
    keyboardType: TextInputType.number,
    validator: (value) =>
        value != null && value.isEmpty ? "Digite um valor válido" : null,
  );

  final spent = TextFieldItem(
    label: "Limite utilizado",
    keyboardType: TextInputType.number,
    validator: (value) =>
        value != null && value.isEmpty ? "Digite um valor válido" : null,
  );
  final closeDate = TextFieldItem(
    label: "Data de fechamento",
    keyboardType: TextInputType.datetime,
    validator: (value) =>
        value != null && value.isEmpty ? "Digite uma data válida" : null,
  );

  final dueDate = TextFieldItem(
    label: "Data de vencimento",
    keyboardType: TextInputType.datetime,
    validator: (value) =>
        value != null && value.isEmpty ? "Digite uma data válida" : null,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.model != null) _fillValues();
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.model == null ? "Cadastrar Cartão" : "Editar Cartão"),
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
              TextFieldWidget(item: nickname),
              TextFieldWidget(item: flag),
              TextFieldWidget(item: limit),
              TextFieldWidget(item: spent),
              TextFieldWidget(item: closeDate),
              TextFieldWidget(item: dueDate),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(widget.model == null ? "Cadastrar" : "Salvar"),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _fillValues() {
    nickname.controller.text = widget.model?.nickname ?? '';
    flag.controller.text = widget.model?.flag ?? '';
    limit.controller.text = widget.model?.limit.toString() ?? '';
    spent.controller.text = widget.model?.spent.toString() ?? '';
  }

  void _register() {
    try {
      final creditCardModel = CreditCardModel(
          accountId: "0",
          flag: flag.controller.text,
          nickname: nickname.controller.text,
          limit: double.parse(limit.controller.text),
          spent: double.parse(spent.controller.text),
          closeDate: DateTime.parse(closeDate.controller.text),
          dueDate: DateTime.parse(dueDate.controller.text));
    } catch (e) {
      print('erro nos dados');
    }
  }
}
