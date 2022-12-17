import 'dart:convert';

import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/utils/i_http_service.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

class CategoryRepository {
  final IHttpService service;

  CategoryRepository({required this.service});
  Future<List<CategoryModel>> loadList() async {
    final List<CategoryModel> _dataList = [];
    final String? dataString =
        await service.get(url: SharedPreferencesKeys.categorys);
    if (dataString != null && dataString.isNotEmpty) {
      final listJson = jsonDecode(dataString);
      final list =
          List.from(listJson).map((e) => CategoryModel.fromJson(e)).toList();
//      return list;
      _dataList.addAll(list);
    }
    if (_dataList.isEmpty) {
      _dataList.addAll([
        CategoryModel(genre: "Outros", color: 0xFF0F0297, type: "Expense"),
        CategoryModel(genre: "Outros", color: 0xFF0F0297, type: "Income"),
        CategoryModel(genre: "Mercado", color: 0xFF5A41FF, type: "Expense"),
        CategoryModel(genre: "Lazer", color: 0xFFE10F00, type: "Expense"),
        CategoryModel(genre: "Combustível", color: 0xFFE6F201, type: "Expense"),
        CategoryModel(genre: "Compras", color: 0xFFF3AA00, type: "Expense"),
        CategoryModel(
            genre: "Entretenimento", color: 0xFF008614, type: "Expense"),
        CategoryModel(
            genre: "Medicamentos", color: 0xFF75F300, type: "Expense"),
        CategoryModel(genre: "Escola", color: 0xFF00CE18, type: "Expense"),
        CategoryModel(genre: "Jantar fora", color: 0xFF00FFF2, type: "Expense"),
        CategoryModel(genre: "Luz", color: 0xFF009B93, type: "Expense"),
        CategoryModel(genre: "Água", color: 0xFF005B57, type: "Expense"),
        CategoryModel(genre: "Internet", color: 0xFF7E34FD, type: "Expense"),
        CategoryModel(genre: "TV a cabo", color: 0xFFCC0483, type: "Expense"),
        CategoryModel(genre: "Bônus", color: 0xFFE10F00, type: "Income"),
        CategoryModel(genre: "Salário", color: 0xFF5A41FF, type: "Income"),
        CategoryModel(genre: "Freelancer", color: 0xFFE6F201, type: "Income"),
        CategoryModel(genre: "Comissão", color: 0xFFF3AA00, type: "Income"),
        CategoryModel(genre: "Reembolso", color: 0xFF008614, type: "Income"),
      ]);
    }

    return _dataList;
  }

  Future<List<CategoryModel>> add(CategoryModel categoryModel) async {
    final List<CategoryModel> _dataList = await loadList();
    _dataList.add(categoryModel);
    await service.set(url: SharedPreferencesKeys.categorys, data: _dataList);
    return _dataList;
  }

  Future<List<CategoryModel>> remove(int index) async {
    final List<CategoryModel> _dataList = await loadList();
    _dataList.removeAt(index);
    await service.set(url: SharedPreferencesKeys.categorys, data: _dataList);
    return _dataList;
  }

  Future<List<CategoryModel>> edit(
      int index, CategoryModel categoryModel) async {
    final List<CategoryModel> _dataList = await loadList();
    _dataList[index] = categoryModel;
    await service.set(url: SharedPreferencesKeys.categorys, data: _dataList);
    return _dataList;
  }
}
