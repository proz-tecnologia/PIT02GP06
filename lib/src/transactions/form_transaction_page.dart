import 'package:flutter/material.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:pit02gp06/src/transactions/transactions_controller.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_formatter.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';
import 'package:uuid/uuid.dart';

import '../category/category_page.dart';

class FormTransactionPage extends StatefulWidget {
  final String type;
  final TransactionModel? transaction;
  final CategoryController categoryController;
  final TransactionsController transactionController;
  const FormTransactionPage(
      {super.key,
      required this.type,
      required this.categoryController,
      required this.transactionController,
      this.transaction});

  @override
  State<FormTransactionPage> createState() => _FormTransactionPageState();
}

class _FormTransactionPageState extends State<FormTransactionPage> {
  final textValueController = TextEditingController();
  final textDesctiptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _selectedCategory = 0;
  DateTime _data = DateTime.now();
  @override
  void initState() {
    super.initState();
    if (widget.type == "Income") {
      _selectedCategory = 1;
    }

    if (widget.transaction != null) {
      _data = widget.transaction!.data;
      textDesctiptionController.text = widget.transaction!.description ?? "";
      textValueController.text = widget.transaction!.valor.toString();
      _selectCategory(widget.transaction!.categoryId);
    }
  }

  void _selectCategory(int index) {
    setState(() {
      _selectedCategory = index;
    });
  }

  void _dateDialog() {
    showDatePicker(
            context: context,
            initialDate: _data,
            firstDate: DateTime(2010),
            lastDate: DateTime(2050))
        .then((value) {
      if (value != null) {
        _data = value;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.type == "Income"
            ? AppColors.blue1Color
            : AppColors.red1Color,
        title: widget.type == "Income"
            ? const Text("Receita")
            : const Text("Despesa"),
        centerTitle: true,
        actions: widget.transaction != null
            ? [
                IconButton(
                  color: AppColors.whiteColor,
                  onPressed: () async {
                    await widget.transactionController
                        .delete(widget.transaction!.id);
                    final snackBar = SnackBar(
                        content: Text(
                            "transação ${widget.transaction!.id} apagada!"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ]
            : [],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: textValueController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return 'preencha com o valor da transação';
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 30),
                      decoration: const InputDecoration(
                        label: Text('Valor'),
                        prefixText: "R\$ ",
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.46,
                      child: Column(
                        children: [
                          IconButton(
                              iconSize: 40,
                              onPressed: _dateDialog,
                              icon: const Icon(Icons.calendar_month)),
                          Text(
                            AppFormatter.date(_data),
                            style: AppTextStyles.textTitle,
                          ),
                        ],
                      )),
                ],
              ),
              TextFormField(
                controller: textDesctiptionController,
                validator: (value) {
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: widget.categoryController.state.value.runtimeType ==
                        CategorySuccessState
                    ? List.generate(
                        (widget.categoryController.state.value
                                    as CategorySuccessState)
                                .categoryList
                                .length +
                            1, (index) {
                        if (index ==
                            (widget.categoryController.state.value
                                    as CategorySuccessState)
                                .categoryList
                                .length) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CategoryPage(
                                          controller: widget.categoryController,
                                          type: widget.type,
                                        )));
                              },
                              child: Chip(
                                avatar: const Icon(Icons.settings),
                                label: const Text("Config. categorias"),
                                backgroundColor: Colors.grey.shade200,
                              ));
                        }

                        return (widget.categoryController.state.value
                                        as CategorySuccessState)
                                    .categoryList[index]
                                    .type !=
                                widget.type
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: (() {
                                  _selectCategory(index);
                                }),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                  child: Chip(
                                    backgroundColor: _selectedCategory == index
                                        ? widget.type == "Income"
                                            ? AppColors.blue1Color
                                            : AppColors.red1Color
                                        : Colors.grey.shade200,
                                    avatar: CircleAvatar(
                                      backgroundColor: Color((widget
                                              .categoryController
                                              .state
                                              .value as CategorySuccessState)
                                          .categoryList[index]
                                          .color),
                                      child: ClipRRect(
                                        child: _selectedCategory == index
                                            ? const Icon(Icons.check)
                                            : Text((widget.categoryController
                                                        .state.value
                                                    as CategorySuccessState)
                                                .categoryList[index]
                                                .genre
                                                .substring(0, 1)),
                                      ),
                                    ),
                                    label: Text(
                                      (widget.categoryController.state.value
                                              as CategorySuccessState)
                                          .categoryList[index]
                                          .genre,
                                      style: _selectedCategory == index
                                          ? AppTextStyles.textChipSelected
                                          : AppTextStyles.textChip,
                                    ),
                                  ),
                                ),
                              );
                      })
                    : [],
              ),
              ElevatedButton(
                  onPressed: _formKey.currentState?.validate() == true
                      ? () {
                          final dataModel = TransactionModel(
                              id: widget.transaction?.id ?? const Uuid().v4(),
                              data: _data,
                              valor: double.parse(textValueController.text),
                              contaId: 0,
                              type: widget.type,
                              categoryId: _selectedCategory,
                              description: textDesctiptionController.text);
                          Navigator.pop(context, dataModel);
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