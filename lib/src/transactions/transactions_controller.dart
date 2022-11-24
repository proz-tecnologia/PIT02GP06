import 'package:flutter/foundation.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/src/transactions/transactions_repository.dart';
import 'package:pit02gp06/src/transactions/transactions_state.dart';
import 'package:pit02gp06/utils/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsController {
  ValueNotifier<TransactionsState> state =
      ValueNotifier(TransactionsEmptyState());
  late final _repository;
  TransactionsController() {
    state.value = TransactionsLoadState();
    init();
  }
  void init() async {
    final instance = await SharedPreferences.getInstance();
    _repository = TransactionsRepository(
        service: SharedPreferencesService(instance: instance));
    List<TransactionModel> transactionsList =
        await _repository.loadTransactions();
    state.value = TransactionsSuccessState(transactionsList: transactionsList);
  }

  void delete(int index, List<TransactionModel> list) {
    state.value = TransactionsLoadState();
    list = _repository.remove(index, list);
    state.value = TransactionsSuccessState(transactionsList: list);
  }

  void add(TransactionModel transaction) async {
    state.value = TransactionsLoadState();
    List<TransactionModel> list = await _repository.loadTransactions();
    list = _repository.add(transaction, list);

    state.value = TransactionsSuccessState(transactionsList: list);
  }

  void save() {
    _repository
        .save((state.value as TransactionsSuccessState).transactionsList);
  }
}
