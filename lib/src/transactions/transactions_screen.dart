import 'package:flutter/material.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/src/category/category_page.dart';
import 'package:pit02gp06/src/transactions/add_transaction_page.dart';
import 'package:pit02gp06/src/transactions/transactions_controller.dart';
import 'package:pit02gp06/src/transactions/transactions_state.dart';
import 'package:pit02gp06/src/widgets/custom_app_bar.dart';
import 'package:pit02gp06/src/widgets/title_widget.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class TransactionsScreen extends StatefulWidget {
  final TransactionsController controller;
  TransactionsScreen({super.key, required this.controller});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();

//   @override
//   void dispose() {}
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TextEditingController newValueController = TextEditingController();
  Object dropDownTypeValue = 0;
  List<String> listType = ['Income', 'Expense'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: "Transações",
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push<TransactionModel?>(
                      MaterialPageRoute(builder: (context) => CategoryPage()));
                },
                icon: Icon(Icons.settings)),
          ],
        ),
        // IconButton(
        //     onPressed: () async {
        //       await Navigator.of(context)
        //           .push<TransactionModel?>(MaterialPageRoute(
        //               builder: (context) => AddTransactionPage(
        //                     type: "Expense",
        //                   )))
        //           .then((value) {
        //         if (value != null && value.runtimeType == TransactionModel) {
        //           widget.controller.add(value);
        //         }
        //       });
        //     },
        //     icon: Icon(Icons.add)),
        SizedBox(
          width: 100,
          child: DropdownButton(
              value: dropDownTypeValue,
              items: [
                DropdownMenuItem(value: 0, child: Text("Receitas")),
                DropdownMenuItem(value: 1, child: Text("Despesas")),
//                DropdownMenuItem(value: 2, child: Text("Todas")),
              ],
              onChanged: (value) {
                setState(() {
                  dropDownTypeValue = value!;
                });
              }),
        ),
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: widget.controller.state,
              builder: (context, value, child) {
                switch (value.runtimeType) {
                  case TransactionsEmptyState:
                    return const Text("VAZIO!!!");
                  case TransactionsLoadState:
                    return CircularProgressIndicator();
                  case TransactionsSuccessState:
                    return ListView.builder(
                        itemCount: (value as TransactionsSuccessState)
                            .transactionsList
                            .length,
                        itemBuilder: (context, index) {
                          return listType[int.parse(
                                      dropDownTypeValue.toString())] !=
                                  value.transactionsList[index].type
                              ? const SizedBox()
                              : ListTile(
                                  iconColor:
                                      value.transactionsList[index].type ==
                                              "Income"
                                          ? AppColors.blue1Color
                                          : AppColors.red1Color,
                                  leading: value.transactionsList[index].type ==
                                          "Income"
                                      ? Icon(Icons.add)
                                      : Icon(Icons.remove),
                                  title: Text(value
                                      .transactionsList[index].valor
                                      .toString()),
                                  trailing: Container(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            widget.controller.delete(index);
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        });
                  default:
                    return const Text("EEERRROOO !!!");
                }
              }),
        ),
      ],
    );

    /*
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              TextField(
                controller: newValueController,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          width: MediaQuery.of(context).size.width,
          child: ValueListenableBuilder(
              valueListenable: controller.state,
              builder: (context, value, child) {
                switch (value.runtimeType) {
                  case TransactionsEmptyState:
                    return const Text("VAZIO!!!");
                  case TransactionsLoadState:
                    return CircularProgressIndicator();
                  case TransactionsSuccessState:
                    return ListView.builder(
                        itemCount: (value as TransactionsSuccessState)
                            .transactionsList
                            .length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            iconColor:
                                value.transactionsList[index] is IncomeModel
                                    ? AppColors.blue1Color
                                    : AppColors.red1Color,
                            leading:
                                value.transactionsList[index] is IncomeModel
                                    ? Icon(Icons.add)
                                    : Icon(Icons.remove),
                            title: Text(
                                value.transactionsList[index].valor.toString()),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: controller.save,
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.delete(
                                          index, value.transactionsList);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  default:
                    return const Text("EEERRROOO !!!");
                }
              }),
        ),
      ],
    );
*/
  }
}
