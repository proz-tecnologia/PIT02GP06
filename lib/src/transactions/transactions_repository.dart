import 'dart:convert';
import 'dart:developer';

import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/utils/i_http_service.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

class TransactionsRepository {
  final IHttpService service;
  TransactionsRepository({required this.service});

  Future<List<TransactionModel>> loadTransactions() async {
    final transactionsString =
        await service.get(url: SharedPreferencesKeys.transactions);
    if (transactionsString != null) {
      final listJsonTransactions = jsonDecode(transactionsString);
      final listTransactions = List.from(listJsonTransactions)
          .map((e) => TransactionModel.fromJson(e))
          .toList();
      return listTransactions;
    }
    return [];
//    log("_repository: listString: ${listString.toString()}");
    // return [
    //   ExpenseModel(data: DateTime.now(), valor: -23, contaId: 0),
    //   IncomeModel(data: DateTime.now(), valor: 20, contaId: 0),
    //   IncomeModel(data: DateTime.now(), valor: 30, contaId: 0),
    //   ExpenseModel(data: DateTime.now(), valor: -80, contaId: 0),
    //   IncomeModel(data: DateTime.now(), valor: 100, contaId: 0),
    //   ExpenseModel(data: DateTime.now(), valor: -70, contaId: 0),
    //   IncomeModel(data: DateTime.now(), valor: 50, contaId: 0),
    //   ExpenseModel(data: DateTime.now(), valor: -23, contaId: 0),
    //   IncomeModel(data: DateTime.now(), valor: 20, contaId: 0),
    //   IncomeModel(data: DateTime.now(), valor: 30, contaId: 0),
    //   ExpenseModel(data: DateTime.now(), valor: -80, contaId: 0),
    // ];
  }

  List<TransactionModel> add(
      TransactionModel transaction, List<TransactionModel> list) {
    list.add(transaction);
    return list;
  }

  List<TransactionModel> remove(int index, List<TransactionModel> list) {
    list.removeAt(index);
    service.set(url: SharedPreferencesKeys.transactions, data: list);
    return list;
  }

  void save(List<TransactionModel> list) async {
    await service.set(url: SharedPreferencesKeys.transactions, data: list);
  }
}
