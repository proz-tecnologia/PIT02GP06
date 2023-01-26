import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

import '../src/authentication_module/auth_repository.dart';

class CategoryRepository {
  Future<List<CategoryModel>> loadList() async {
    final user = await Modular.get<AuthRepository>().getUser();

    final collections = FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.categorys)
        .where('uid', isEqualTo: user.uid);

    var result = await collections.get();
    List<CategoryModel> list = [];
    for (var doc in result.docs) {
      list.add(CategoryModel(
        uid: doc['uid'],
        type: doc['type'],
        genre: doc['genre'],
        color: doc['color'],
        count: doc['count'],
        id: doc.id,
      ));
    }
    if (list.isEmpty) {
      list.addAll([
        CategoryModel(
            uid: user.uid,
            genre: "Outros",
            color: 0xFF0F0297,
            type: "Expense",
            id: "${user.uid}+0"),
        CategoryModel(
            uid: user.uid,
            genre: "Outros",
            color: 0xFF0F0297,
            type: "Income",
            id: "${user.uid}+1"),
        CategoryModel(
            uid: user.uid,
            genre: "Mercado",
            color: 0xFF5A41FF,
            type: "Expense",
            id: "${user.uid}+2"),
        CategoryModel(
            uid: user.uid,
            genre: "Lazer",
            color: 0xFFE10F00,
            type: "Expense",
            id: "${user.uid}+3"),
        CategoryModel(
            uid: user.uid,
            genre: "Combustível",
            color: 0xFFE6F201,
            type: "Expense",
            id: "${user.uid}+4"),
        CategoryModel(
            uid: user.uid,
            genre: "Medicamentos",
            color: 0xFF75F300,
            type: "Expense",
            id: "${user.uid}+5"),
        CategoryModel(
            uid: user.uid,
            genre: "Escola",
            color: 0xFF00CE18,
            type: "Expense",
            id: "${user.uid}+6"),
        CategoryModel(
            uid: user.uid,
            genre: "Luz",
            color: 0xFF009B93,
            type: "Expense",
            id: "${user.uid}+7"),
        CategoryModel(
            uid: user.uid,
            genre: "Água",
            color: 0xFF005B57,
            type: "Expense",
            id: "${user.uid}+8"),
        CategoryModel(
            uid: user.uid,
            genre: "Internet",
            color: 0xFF7E34FD,
            type: "Expense",
            id: "${user.uid}+9"),
        CategoryModel(
            uid: user.uid,
            genre: "TV a cabo",
            color: 0xFFCC0483,
            type: "Expense",
            id: "${user.uid}+10"),
        CategoryModel(
            uid: user.uid,
            genre: "Bônus",
            color: 0xFFE10F00,
            type: "Income",
            id: "${user.uid}+11"),
        CategoryModel(
            uid: user.uid,
            genre: "Salário",
            color: 0xFF5A41FF,
            type: "Income",
            id: "${user.uid}+12"),
        CategoryModel(
            uid: user.uid,
            genre: "Freelancer",
            color: 0xFFE6F201,
            type: "Income",
            id: "${user.uid}+13"),
        CategoryModel(
            uid: user.uid,
            genre: "Comissão",
            color: 0xFFF3AA00,
            type: "Income",
            id: "${user.uid}+14"),
        CategoryModel(
            uid: user.uid,
            genre: "Reembolso",
            color: 0xFF008614,
            type: "Income",
            id: "${user.uid}+15"),
      ]);
      for (var element in list) {
        save(element);
      }
    }
    list.sort((a, b) => a.genre.compareTo(b.genre));
    return list;
  }

  Future<CategoryModel> loadDoc(String id) async {
    final collections =
        FirebaseFirestore.instance.collection(SharedPreferencesKeys.categorys);
    final res = await collections.doc(id).get();
    final category = CategoryModel(
      uid: res['uid'],
      genre: res['genre'],
      color: res['color'],
      type: res['type'],
      count: res['count'],
      id: res.id,
    );
    return category;
  }

  Future<void> save(CategoryModel category) async {
    FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.categorys)
        .doc(category.id)
        .set({
      'uid': category.uid,
      'genre': category.genre,
      'color': category.color,
      'type': category.type,
      'id': category.id,
      'count': category.count,
    });
  }

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance
        .collection(SharedPreferencesKeys.categorys)
        .doc(id)
        .delete();
  }
}
