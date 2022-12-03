import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pit02gp06/models/transaction_model.dart';

class AddTransactionPage extends StatefulWidget {
  String type;
  AddTransactionPage({super.key, required this.type});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00127A),
        title: Text("Adicionar Transação de ${widget.type}"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: textController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'preencha com um valor válido';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Valor (Ex. 15.30 ou -8.99)'),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  onPressed: _formKey.currentState?.validate() == true
                      ? () {
                          log('---> newNotePage -->  validate=true -> cria newNote');

                          final newNote = TransactionModel(
                              data: DateTime.now(),
                              valor: double.parse(textController.text),
                              contaId: 0,
                              type: widget.type);
                          log('---> newNotePage -->  navega devolta para home');
                          Navigator.pop(context, newNote);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00127A),
                    fixedSize: Size(MediaQuery.of(context).size.width / 2, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(80, 80))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Salvar nota"),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.save),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
