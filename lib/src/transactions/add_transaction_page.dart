import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:pit02gp06/utils/app_colors.dart';

import '../../models/category_model.dart';
import '../category/category_page.dart';
import '../category/form_category_page.dart';
import '../widgets/select_color_modal.dart';

class AddTransactionPage extends StatefulWidget {
  String type;
  TransactionModel? transaction;
  final CategoryController categoryController;
  AddTransactionPage(
      {super.key,
      required this.type,
      required this.categoryController,
      this.transaction});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final textValueController = TextEditingController();
  final textDesctiptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _selectedCategory = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.type == "Income") {
      _selectedCategory = 1;
    }

    if (widget.transaction != null) {
      textDesctiptionController.text = widget.transaction!.description ?? "";
      textValueController.text = widget.transaction!.valor.toString();
      selectCategory(widget.transaction!.categoryId);
    }
  }

  void selectCategory(int index) {
    setState(() {
      _selectedCategory = index;
    });
  }

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
                controller: textValueController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'preencha com o valor da transação';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Valor'),
                ),
              ),
              TextFormField(
                autofocus: true,
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
                            : OutlinedButton(
                                onPressed: (() {
                                  selectCategory(index);
                                }),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Color(categoryList[index].color),
                                    child: ClipRRect(
                                      child: _selectedCategory == index
                                          ? const Icon(Icons.check)
                                          : Text(categoryList[index]
                                              .genre
                                              .substring(0, 1)),
                                    ),
                                  ),
                                  title: Text(categoryList[index].genre),
                                  trailing: SizedBox(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.color_lens,
                                            color: Color(
                                                categoryList[index].color),
                                          ),
                                          onPressed: () async {
                                            var color;
                                            color =
                                                await SelectColorModal(context);
                                            log("color retornada $color");
                                            if (color != null &&
                                                color.runtimeType == int) {
                                              categoryList[index].color = color;
                                              widget.categoryController.edit(
                                                  index, categoryList[index]);
                                            }
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await Navigator.of(context)
                                                .push<CategoryModel?>(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FormCategoryPage(
                                                                type:
                                                                    widget.type,
                                                                category:
                                                                    categoryList[
                                                                        index])))
                                                .then((value) {
                                              if (value != null &&
                                                  value.runtimeType ==
                                                      CategoryModel) {
                                                widget.categoryController
                                                    .edit(index, value);
                                              }
                                            });
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (index < 2) {
                                              const snackBar = SnackBar(
                                                content: Text(
                                                    'Este ítem não pode ser excluído!'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              return;
                                            }
                                            widget.categoryController
                                                .delete(index);
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      },
                    );
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoryPage(
                            controller: widget.categoryController)));
                  },
                  icon: const Icon(Icons.settings)),
              ElevatedButton(
                  onPressed: _formKey.currentState?.validate() == true
                      ? () {
                          log('---> newNotePage -->  validate=true -> cria newNote');

                          final newNote = TransactionModel(
                              data: DateTime.now(),
                              valor: double.parse(textValueController.text),
                              contaId: 0,
                              type: widget.type,
                              categoryId: _selectedCategory,
                              description: textDesctiptionController.text);
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
