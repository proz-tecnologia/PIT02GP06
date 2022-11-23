import 'package:flutter/foundation.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/src/transactions/transactions_repository.dart';
import 'package:pit02gp06/src/transactions/transactions_state.dart';

class TransactionsController {
  ValueNotifier<TransactionsState> state =
      ValueNotifier(TransactionsEmptyState());
  final _repository = TransactionsRepository();
  TransactionsController() {
    state.value = TransactionsLoadState();
    List<TransactionModel> transactionsList;
    transactionsList = _repository.loadTransactions();
    state.value = TransactionsSuccessState(transactionsList: transactionsList);
  }

  void delete(int index, List<TransactionModel> list) {
    state.value = TransactionsLoadState();
    list = _repository.remove(index, list);
    state.value = TransactionsSuccessState(transactionsList: list);
  }

  void add(TransactionModel transaction, List<TransactionModel> list) {
    state.value = TransactionsLoadState();
    list = _repository.add(transaction, list);
    state.value = TransactionsSuccessState(transactionsList: list);
  }
}
