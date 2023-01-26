import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/src/authentication_module/auth_repository.dart';
import 'package:pit02gp06/src/home_module/category/category_controller.dart';
import 'package:pit02gp06/src/home_module/category/category_states.dart';
import 'package:pit02gp06/src/home_module/credit_card/credit_card_controller.dart';
import 'package:pit02gp06/src/home_module/credit_card/credit_card_state.dart';
import 'package:pit02gp06/src/home_module/transactions/transactions_controller.dart';
import 'package:pit02gp06/src/home_module/transactions/widgets/button_count_select.dart';
import 'package:pit02gp06/src/home_module/transactions/widgets/button_credit_card_select.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_formatter.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';

import '../../widgets/credit_card_widget.dart';
import '../category/category_page.dart';
import '../credit_card/add_credit_card_button.dart';

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
  final creditCardController = Modular.get<CreditCardController>();
  final textValueController = TextEditingController();
  final textDesctiptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = "";
  String? _selectedCreditCardId;
  DateTime _data = DateTime.now();
  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      _data = widget.transaction!.date;
      textDesctiptionController.text = widget.transaction!.description ?? "";
      textValueController.text = widget.transaction!.value.toString();
      _selectCategory(widget.transaction!.categoryId);
      _selectCreditCard(widget.transaction!.creditCardId);
    }
  }

  void _selectCategory(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
  }

  void _selectCreditCard(String? creditCardId) {
    setState(() {
      _selectedCreditCardId = creditCardId;
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
        setState(() {
          _data = value;
        });
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
                    widget.categoryController
                        .decrementCount(widget.transaction!.categoryId);
                    await widget.transactionController
                        .delete(widget.transaction!.id!);

                    final user = await Modular.get<AuthRepository>().getUser();

                    user.balance = widget.type == 'Income'
                        ? user.balance -= widget.transaction!.value
                        : user.balance += widget.transaction!.value;

                    Modular.get<AuthRepository>().setUser(user);
                    if (widget.transaction!.creditCardId != null) {
                      await creditCardController.decrementCount(
                          widget.transaction!.creditCardId!,
                          widget.transaction!.value);
                    }
                    final snackBar = SnackBar(
                        content: Text(
                            "transação ${widget.transaction!.id} apagada!"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context, widget.transaction!);
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
              if (widget.type == 'Expense')
                SizedBox(
                  height: 100,
                  child: ValueListenableBuilder(
                    valueListenable: creditCardController.state,
                    builder: (context, value, child) {
                      switch (value.runtimeType) {
                        case CreditCardLoadState:
                          return LinearProgressIndicator(
                            backgroundColor: AppColors.backgroundColor,
                            color: AppColors.whiteColor,
                          );
                        case CreditCardSuccessState:
                          final listCreditCards =
                              (value as CreditCardSuccessState).list;
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listCreditCards.length + 1,
                              itemBuilder: ((context, index) {
                                if (index > 0) {
                                  return ButtonCreditCardSelect(
                                      selectCreditCard: _selectCreditCard,
                                      creditCard: listCreditCards[index - 1],
                                      selectedCreditCard:
                                          _selectedCreditCardId);
                                } else {
                                  return ButtonCountSelect(
                                      selectCreditCard: _selectCreditCard,
                                      selectedCreditCard:
                                          _selectedCreditCardId);
                                }
                              }));

                        default:
                          return ButtonCountSelect(
                              selectCreditCard: _selectCreditCard,
                              selectedCreditCard: _selectedCreditCardId);
                      }
                    },
                  ),
                ),
              if (widget.type == 'Expense')
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
                                backgroundColor: AppColors.chipGreyColor,
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
                                  _selectCategory((widget.categoryController
                                          .state.value as CategorySuccessState)
                                      .categoryList[index]
                                      .id!);
                                }),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                  child: Chip(
                                    backgroundColor: _selectedCategory ==
                                            (widget.categoryController.state
                                                        .value
                                                    as CategorySuccessState)
                                                .categoryList[index]
                                                .id!
                                        ? widget.type == "Income"
                                            ? AppColors.blue1Color
                                            : AppColors.red1Color
                                        : AppColors.chipGreyColor,
                                    avatar: CircleAvatar(
                                      backgroundColor: Color((widget
                                              .categoryController
                                              .state
                                              .value as CategorySuccessState)
                                          .categoryList[index]
                                          .color),
                                      child: ClipRRect(
                                        child: _selectedCategory ==
                                                (widget.categoryController.state
                                                            .value
                                                        as CategorySuccessState)
                                                    .categoryList[index]
                                                    .id!
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
                                      style: _selectedCategory ==
                                              (widget.categoryController.state
                                                          .value
                                                      as CategorySuccessState)
                                                  .categoryList[index]
                                                  .id!
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
                  onPressed: _formKey.currentState?.validate() == true &&
                          _selectedCategory.isNotEmpty
                      ? () async {
                          final user =
                              await Modular.get<AuthRepository>().getUser();

                          if (widget.transaction == null) {
                            widget.categoryController
                                .incrementCount(_selectedCategory);
                          } else if (widget.transaction!.categoryId !=
                              _selectedCategory) {
                            widget.categoryController
                                .decrementCount(widget.transaction!.categoryId);
                            widget.categoryController
                                .incrementCount(_selectedCategory);
                          }

                          final dataModel = TransactionModel(
                              id: widget.transaction?.id,
                              date: _data,
                              value: double.parse(textValueController.text),
                              uid: user.uid,
                              type: widget.type,
                              categoryId: _selectedCategory,
                              creditCardId: _selectedCreditCardId,
                              description: textDesctiptionController.text);
                          widget.transactionController.save(dataModel);
                          user.balance = widget.type == 'Income'
                              ? user.balance += dataModel.value
                              : user.balance -= dataModel.value;
                          if (_selectedCreditCardId != null) {
                            await creditCardController.incrementCount(
                                _selectedCreditCardId!, dataModel.value);
                          }
                          //caso seja edição, removendo valor antigo
                          if (widget.transaction != null) {
                            user.balance = widget.type == 'Income'
                                ? user.balance -= widget.transaction!.value
                                : user.balance += widget.transaction!.value;
                            if (widget.transaction!.creditCardId != null) {
                              await creditCardController.decrementCount(
                                  widget.transaction!.creditCardId!,
                                  widget.transaction!.value);
                            }
                          }
                          Modular.get<AuthRepository>().setUser(user);

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

// class ButtonCountSelect extends StatelessWidget {
//   const ButtonCountSelect({
//     Key? key,
//     required String? selectedCreditCard,
//   }) : _selectedCreditCard = selectedCreditCard, super(key: key);

//   final String? _selectedCreditCard;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       child: Card(
//         color: _selectedCreditCard == null
//             ? AppColors.red1Color
//             : AppColors.chipGreyColor,
//         child: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.spaceAround,
//           children: [
//             Text('À vista'),
//             Text(
//               'Conta',
//               style: _selectedCreditCard == null
//                   ? AppTextStyles.textChipSelected
//                   : AppTextStyles.textChip,
//             ),
//             Icon(Icons.attach_money),
//           ],
//         ),
//       ),
//     );
//   }

