import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/resume_model.dart';
import 'package:pit02gp06/src/authentication/auth_repository.dart';
import 'package:pit02gp06/src/home/home_state.dart';

import '../../models/category_model.dart';
import '../../models/transaction_model.dart';

class HomeController {
  final state = ValueNotifier<HomeState>(HomeEmptyState());

  update(List<TransactionModel> transactions,
      List<CategoryModel> categoryes) async {
    state.value = HomeLoadingState();
    await Future.delayed(const Duration(milliseconds: 500));
    final user = await Modular.get<AuthRepository>().getUser();
    double balance = 0;
    double income = 0;
    double spend = 0;
    for (var e in transactions) {
      if (e.type == "Income") {
        balance += e.value;
        income += e.value;
      } else if (e.type == "Expense") {
        balance -= e.value;
        spend += e.value;
      }
    }
    final resume = ResumeModel(balance: balance, income: income, spend: spend);
    final List<Map<String, Object>> listExpenseByCategory =
        expenseByCategory(transactions, categoryes);
    state.value = HomeSuccessState(
        resume: resume,
        user: user,
        listExpenseByCategory: listExpenseByCategory);
  }

  List<Map<String, Object>> expenseByCategory(
      List<TransactionModel> transactions, List<CategoryModel> categoryes) {
    List<Map<String, Object>> data = [];
    List<Map<String, Object>> expenseData = [];

    categoryes.forEach((category) {
      Map<String, Object> pieObj = {
        'genre': category.genre,
        'sold': 0.0,
        'color': category.color,
        'type': category.type,
      };
      data.add(pieObj);
    });

    transactions.forEach((transaction) {
      Map<String, Object> pieObj = data[transaction.categoryId];
      double sold = (pieObj['sold'] as double);
      sold += transaction.value;
      pieObj['sold'] = sold;
      data[transaction.categoryId] = pieObj;
    });

    data.forEach((pieObj) {
      if (pieObj['type'] == "Expense" && (pieObj['sold'] as double) > 0) {
        expenseData.add(pieObj);
      }
    });

    // data = [
    //   {'genre': 'Lazer', 'sold': 200, 'color': 0xFF5A41FF},
    //   {'genre': 'Transporteeeeee', 'sold': 130, 'color': 0xFF0F0297},
    //   {'genre': 'Casa', 'sold': 300, 'color': 0xFFE10F00},
    //   {'genre': 'Outros', 'sold': 50, 'color': 0xFFE6F201},
    // ];
    return expenseData;
  }
}
