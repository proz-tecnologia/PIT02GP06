import 'package:pit02gp06/models/transaction_model.dart';

abstract class TransactionsState {}

class TransactionsLoadState extends TransactionsState {}

class TransactionsSuccessState extends TransactionsState {
  final List<TransactionModel> transactionsList;

  TransactionsSuccessState({required this.transactionsList});
}

class TransactionsEmptyState extends TransactionsState {}

class TransactionsErrorState extends TransactionsState {}
