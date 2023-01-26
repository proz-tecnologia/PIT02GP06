import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

import '../src/authentication_module/auth_repository.dart';

class CreditCardRepository {
  CreditCardRepository();

  Future<List<CreditCardModel>> loadList() async {
    final user = await Modular.get<AuthRepository>().getUser();

    final collections = FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.creditCards)
        .where('uid', isEqualTo: user.uid);

    var result = await collections.get();
    List<CreditCardModel> list = [];
    for (var doc in result.docs) {
      list.add(CreditCardModel(
        id: doc.id,
        uid: doc['uid'],
        flag: doc['flag'],
        nickname: doc['nickname'],
        limit: doc['limit'],
        spent: doc['spent'],
        closeDate: (doc['closeDate'] as Timestamp).toDate(),
        dueDate: (doc['dueDate'] as Timestamp).toDate(),
      ));
    }
    list.sort((b, a) => a.spent.compareTo(b.spent));
    return list;
  }

  Future<CreditCardModel> loadDoc(String id) async {
    final collections = FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.creditCards);
    final doc = await collections.doc(id).get();
    final creditCard = CreditCardModel(
      id: id,
      uid: doc['uid'],
      flag: doc['flag'],
      nickname: doc['nickname'],
      limit: doc['limit'],
      spent: doc['spent'],
      closeDate: (doc['closeDate'] as Timestamp).toDate(),
      dueDate: (doc['dueDate'] as Timestamp).toDate(),
    );
    return creditCard;
  }

  Future<void> save(CreditCardModel creditCard) async {
    FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.creditCards)
        .doc(creditCard.id)
        .set({
      'uid': creditCard.uid,
      'flag': creditCard.flag,
      'nickname': creditCard.nickname,
      'limit': creditCard.limit,
      'spent': creditCard.spent,
      'closeDate': creditCard.closeDate,
      'dueDate': creditCard.dueDate,
    });
  }

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.creditCards)
        .doc(id)
        .delete();
  }
}
