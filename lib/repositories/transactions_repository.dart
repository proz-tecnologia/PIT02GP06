import 'dart:convert';

import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/utils/i_http_service.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

class TransactionsRepository {
  final IHttpService service;
  TransactionsRepository({required this.service});

  Future<List<TransactionModel>> loadTransactions() async {
    final String? transactionsString =
        await service.get(url: SharedPreferencesKeys.transactions);
    if (transactionsString != null && transactionsString.isNotEmpty) {
      final listJsonTransactions = jsonDecode(transactionsString);
      final listTransactions = List.from(listJsonTransactions)
          .map((e) => TransactionModel.fromJson(e))
          .toList();
      listTransactions.sort((b, a) => a.data.compareTo(b.data));
      return listTransactions;
    }
    return [];
  }

  Future add(TransactionModel transaction) async {
    List<TransactionModel> list = await loadTransactions();
    list.add(transaction);
    await service.set(url: SharedPreferencesKeys.transactions, data: list);
  }

  Future remove(String id) async {
    List<TransactionModel> list = await loadTransactions();
    for (var element in list) {
      if (element.id == id) {
        list.remove(element);
        break;
      }
    }
    //list.remove(value);
    await service.set(url: SharedPreferencesKeys.transactions, data: list);
  }

  Future edit(int index, TransactionModel transactionModel) async {
    List<TransactionModel> list = await loadTransactions();
    list[index] = transactionModel;
    await service.set(url: SharedPreferencesKeys.transactions, data: list);
  }
}
