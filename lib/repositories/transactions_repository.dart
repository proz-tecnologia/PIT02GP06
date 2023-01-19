import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/transaction_model.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

import '../src/authentication/auth_repository.dart';

class TransactionsRepository {
  TransactionsRepository();

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

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.transactions)
        .doc(id)
        .delete();
  }
}
