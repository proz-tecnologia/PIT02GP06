import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/pie_chart_model.dart';
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
    Map<String, PieChartModel> data = {};
    List<Map<String, Object>> expenseData = [];

    for (var category in categoryes) {
      PieChartModel pieObj = PieChartModel(
          genre: category.genre,
          sold: 0.0,
          color: category.color,
          type: category.type);
      data.addAll({category.id!: pieObj});
    }

    for (var transaction in transactions) {
      data[transaction.categoryId]!.sold += transaction.value;
    }
    data.forEach((key, value) {
      if (value.type == "Expense" && value.sold > 0) {
        expenseData.add(
            {'genre': value.genre, 'sold': value.sold, 'color': value.color});
      }
    });

    return expenseData;
  }
}
