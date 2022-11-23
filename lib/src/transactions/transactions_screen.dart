import 'package:flutter/material.dart';
import 'package:pit02gp06/models/income_model.dart';
import 'package:pit02gp06/src/transactions/transactions_controller.dart';
import 'package:pit02gp06/src/transactions/transactions_state.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class TransactionsScreen extends StatefulWidget {
  TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final controller = TransactionsController();

  @override
  Widget build(BuildContext context) {
    return Center(
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
                        iconColor: value.transactionsList[index] is IncomeModel
                            ? AppColors.blue1Color
                            : AppColors.red1Color,
                        leading: value.transactionsList[index] is IncomeModel
                            ? Icon(Icons.add)
                            : Icon(Icons.remove),
                        title: Text(
                            value.transactionsList[index].valor.toString()),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
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
    );
  }
}
