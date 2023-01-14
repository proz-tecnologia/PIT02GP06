import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/utils/i_http_service.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

import '../src/authentication/auth_repository.dart';

class TransactionsRepository {
  final IHttpService service;
  TransactionsRepository({required this.service});

  Future<List<TransactionModel>> loadTransactions() async {
    final user = await Modular.get<AuthRepository>().getUser();

    final collections = FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.transactions)
        .where('uid', isEqualTo: user.uid);

    var result = await collections.get();
    List<TransactionModel> list = [];
    for (var doc in result.docs) {
      list.add(TransactionModel(
        uid: doc['uid'],
        type: doc['type'],
        date: (doc['date'] as Timestamp).toDate(),
        value: doc['value'],
        description: doc['description'],
        categoryId: doc['categoryId'],
        id: doc.id,
      ));
    }
    list.sort((b, a) => a.date.compareTo(b.date));
    return list;
  }

  // Future<List<TransactionModel>> loadTransactions() async {
  //   final String? transactionsString =
  //       await service.get(url: SharedPreferencesKeys.transactions);
  //   if (transactionsString != null && transactionsString.isNotEmpty) {
  //     final listJsonTransactions = jsonDecode(transactionsString);
  //     final listTransactions = List.from(listJsonTransactions)
  //         .map((e) => TransactionModel.fromJson(e))
  //         .toList();
  //     listTransactions.sort((b, a) => a.data.compareTo(b.data));
  //     return listTransactions;
  //   }
  //   return [];
  // }

  Future<void> save(TransactionModel transaction) async {
    FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.transactions)
        .doc(transaction.id)
        .set({
      'uid': transaction.uid,
      'date': transaction.date,
      'value': transaction.value,
      'type': transaction.type,
      'categoryId': transaction.categoryId,
      'description': transaction.description,
    });
  }

  void delete(String id) {
    FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.transactions)
        .doc(id)
        .delete();
  }
  // Future add(TransactionModel transaction) async {
  //   List<TransactionModel> list = await loadTransactions();
  //   list.add(transaction);
  //   await service.set(url: SharedPreferencesKeys.transactions, data: list);
  // }

  // Future remove(String id) async {
  //   List<TransactionModel> list = await loadTransactions();
  //   for (var element in list) {
  //     if (element.id == id) {
  //       list.remove(element);
  //       break;
  //     }
  //   }
  //   //list.remove(value);
  //   await service.set(url: SharedPreferencesKeys.transactions, data: list);
  // }

  // Future edit(int index, TransactionModel transactionModel) async {
  //   List<TransactionModel> list = await loadTransactions();
  //   list[index] = transactionModel;
  //   await service.set(url: SharedPreferencesKeys.transactions, data: list);
  // }
}
