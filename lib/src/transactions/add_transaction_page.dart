import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class AddTransactionPage extends StatefulWidget {
  String type;
  final CategoryController categoryController;
  AddTransactionPage(
      {super.key, required this.type, required this.categoryController});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
//    widget.categoryBloc.inputCategory.close();
//    bloc.inputCategory.close();
  }

  @override
  Widget build(BuildContext context) {
    // widget.categoryBloc.stream.listen((event) {
    //   log("ADDTRANSACTION.widget.catBloc.stream é ${event.runtimeType}");
    // });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.type == "Income"
            ? AppColors.blue1Color
            : AppColors.red1Color,
        title: widget.type == "Income"
            ? const Text("Nova Receita")
            : const Text("Nova Despesa"),
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
                autofocus: true,
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
                  label: Text('Valor (Ex. 19.99)'),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                height: 300,
                width: 200,
                child: ValueListenableBuilder(
                  valueListenable: widget.categoryController.state,
                  builder: (context, value, child) {
                    final categoryList =
                        value.runtimeType == CategorySuccessState
                            ? (value as CategorySuccessState).categoryList
                            : [];
                    return ListView.builder(
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return categoryList[index].type != widget.type
                            ? const SizedBox()
                            : Text(categoryList[index].genre +
                                categoryList[index].type);
                      },
                    );
                  },
                ),
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
                    backgroundColor: widget.type == "Income"
                        ? AppColors.blue1Color
                        : AppColors.red1Color,
                    fixedSize: Size(MediaQuery.of(context).size.width / 2, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Salvar"),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.arrow_right_outlined),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
