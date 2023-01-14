import 'package:flutter/foundation.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/repositories/transactions_repository.dart';
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

  Future delete(String id) async {
    state.value = TransactionsLoadState();
    await _repository.remove(id);
    List<TransactionModel> list = await _repository.loadTransactions();
    state.value = TransactionsSuccessState(transactionsList: list);
  }

  void save(TransactionModel transaction) async {
    state.value = TransactionsLoadState();
    await _repository.save(transaction);
    List<TransactionModel> list = await _repository.loadTransactions();
    state.value = TransactionsSuccessState(transactionsList: list);
  }

  // void add(TransactionModel transaction) async {
  //   state.value = TransactionsLoadState();
  //   await _repository.add(transaction);
  //   List<TransactionModel> list = await _repository.loadTransactions();
  //   state.value = TransactionsSuccessState(transactionsList: list);
  // }

  // void edit(int index, TransactionModel category) async {
  //   state.value = TransactionsLoadState();
  //   await _repository.edit(index, category);
  //   List<TransactionModel> list = await _repository.loadTransactions();
  //   state.value = TransactionsSuccessState(transactionsList: list);
  // }
}
