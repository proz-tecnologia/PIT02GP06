import 'package:flutter/material.dart';
import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/category/category_page.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:pit02gp06/src/transactions/form_transaction_page.dart';
import 'package:pit02gp06/src/transactions/transactions_controller.dart';
import 'package:pit02gp06/src/transactions/transactions_state.dart';
import 'package:pit02gp06/src/widgets/custom_app_bar.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_formatter.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';

class TransactionsScreen extends StatefulWidget {
  final TransactionsController transactionController;
  final CategoryController categoryController;
  TransactionsScreen(
      {super.key,
      required this.transactionController,
      required this.categoryController});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();

//   @override
//   void dispose() {}
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TextEditingController newValueController = TextEditingController();
  Object dropDownTypeValue = 2;
  List<String> listType = ['Income', 'Expense', 'All'];

  late List<CategoryModel> categoryList;
  @override
  void initState() {
    if (widget.categoryController.state.value.runtimeType ==
        CategorySuccessState) {
      categoryList =
          (widget.categoryController.state.value as CategorySuccessState)
              .categoryList;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: "Transações",
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CategoryPage(controller: widget.categoryController)));
                },
                icon: const Icon(Icons.settings)),
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
              items: const [
                DropdownMenuItem(value: 0, child: Text("Receitas")),
                DropdownMenuItem(value: 1, child: Text("Despesas")),
                DropdownMenuItem(value: 2, child: Text("Todas")),
              ],
              onChanged: (value) {
                setState(() {
                  dropDownTypeValue = value!;
                });
              }),
        ),
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: widget.transactionController.state,
              builder: (context, value, child) {
                switch (value.runtimeType) {
                  case TransactionsEmptyState:
                    return const Text("VAZIO!!!");
                  case TransactionsLoadState:
                    return const CircularProgressIndicator();
                  case TransactionsSuccessState:
                    return ListView.builder(
                        reverse: true,
                        itemCount: (value as TransactionsSuccessState)
                            .transactionsList
                            .length,
                        itemBuilder: (context, index) {
                          final type =
                              listType[int.parse(dropDownTypeValue.toString())];
                          // return listType[int.parse(
                          //             dropDownTypeValue.toString())] !=
                          //         value.transactionsList[index].type
                          //     ? const SizedBox()
                          //     : ListTile(
                          return type != "All" &&
                                  type != value.transactionsList[index].type
                              ? SizedBox()
                              : Card(
                                  child: ListTile(
                                    minLeadingWidth: 4,
                                    onTap: (() async {
                                      //               Navigator.of(context).push(MaterialPageRoute(
                                      // builder: (context) => CategoryPage(
                                      //     controller: widget.categoryController)));

                                      await Navigator.of(context)
                                          .push<TransactionModel?>(
                                              MaterialPageRoute(
                                        builder: (context) =>
                                            FormTransactionPage(
                                          type: value
                                              .transactionsList[index].type,
                                          categoryController:
                                              widget.categoryController,
                                          transaction:
                                              value.transactionsList[index],
                                        ),
                                      ))
                                          .then((value) {
                                        if (value != null &&
                                            value.runtimeType ==
                                                TransactionModel) {
                                          widget.transactionController
                                              .edit(index, value);
                                        }
                                      });
                                    }),
                                    iconColor:
                                        value.transactionsList[index].type ==
                                                "Income"
                                            ? AppColors.blue1Color
                                            : AppColors.red1Color,
                                    leading: Container(
                                      width: 6,
                                      color:
                                          value.transactionsList[index].type ==
                                                  "Income"
                                              ? AppColors.blue1Color
                                              : AppColors.red1Color,
                                    ),
                                    title: Text(
                                      AppFormatter.moneyWithRs(
                                          value.transactionsList[index].valor),
                                      style: AppTextStyles.textTitle,
                                    ),
                                    subtitle: Wrap(
                                      children: [
                                        Text(AppFormatter
                                            .dateExtenseOcultCurrentYear(value
                                                .transactionsList[index].data)),
                                        VerticalDivider(),
                                        Text(value.transactionsList[index]
                                                .description ??
                                            ""),
                                      ],
                                    ),
                                    trailing: Expanded(
//                                      width: 150,
                                      child: Chip(
                                        backgroundColor: Colors.grey.shade200,
                                        avatar: Icon(
                                          Icons.circle,
                                          color: Color(categoryList[value
                                                  .transactionsList[index]
                                                  .categoryId]
                                              .color),
                                        ),
                                        label: Text(categoryList[value
                                                .transactionsList[index]
                                                .categoryId]
                                            .genre),
                                      ),
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
