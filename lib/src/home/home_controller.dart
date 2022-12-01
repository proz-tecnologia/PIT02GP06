import 'package:flutter/foundation.dart';
import 'package:pit02gp06/models/resume_model.dart';
import 'package:pit02gp06/src/home/home_state.dart';

import '../../models/transaction_model.dart';

class HomeController {
  final state = ValueNotifier<HomeState>(HomeEmptyState());

  update(List<TransactionModel> transactions) async {
    state.value = HomeLoadingState();
    await Future.delayed(const Duration(seconds: 1));
    double balance = 0;
    double income = 0;
    double spend = 0;
    transactions.forEach((e) {
      balance += e.valor;
      if (e.valor < 0)
        spend += e.valor;
      else
        income += e.valor;
    });
    final resume = ResumeModel(balance: balance, income: income, spend: spend);
    state.value = HomeSuccessState(resume: resume);
  }
}
