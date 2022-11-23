import 'package:pit02gp06/models/transaction_model.dart';

import '../../models/expense_model.dart';
import '../../models/income_model.dart';

class TransactionsRepository {
  List<TransactionModel> loadTransactions() {
    return [
      IncomeModel(data: DateTime.now(), valor: 100, contaId: 0),
      ExpenseModel(data: DateTime.now(), valor: -70, contaId: 0),
      IncomeModel(data: DateTime.now(), valor: 50, contaId: 0),
      ExpenseModel(data: DateTime.now(), valor: -23, contaId: 0),
      IncomeModel(data: DateTime.now(), valor: 20, contaId: 0),
      IncomeModel(data: DateTime.now(), valor: 30, contaId: 0),
      ExpenseModel(data: DateTime.now(), valor: -80, contaId: 0),
      IncomeModel(data: DateTime.now(), valor: 100, contaId: 0),
      ExpenseModel(data: DateTime.now(), valor: -70, contaId: 0),
      IncomeModel(data: DateTime.now(), valor: 50, contaId: 0),
      ExpenseModel(data: DateTime.now(), valor: -23, contaId: 0),
      IncomeModel(data: DateTime.now(), valor: 20, contaId: 0),
      IncomeModel(data: DateTime.now(), valor: 30, contaId: 0),
      ExpenseModel(data: DateTime.now(), valor: -80, contaId: 0),
    ];
  }

  List<TransactionModel> add(
      TransactionModel transaction, List<TransactionModel> list) {
    list.add(transaction);
    return list;
  }

  List<TransactionModel> remove(int index, List<TransactionModel> list) {
    list.removeAt(index);
    return list;
  }
}
