import 'dart:convert';
import 'dart:developer';

import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/utils/i_http_service.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

class CategoryRepository {
  final IHttpService service;
  final List<CategoryModel> _dataList = [];
  CategoryRepository({required this.service});
  Future<List<CategoryModel>> loadList() async {
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
        CategoryModel(genre: "Lazer", color: 0xFF5A41FF, type: "Expense"),
        CategoryModel(genre: "Salário", color: 0xFF5A41FF, type: "Income"),
        CategoryModel(genre: "Casa", color: 0xFFE10F00, type: "Expense"),
        CategoryModel(genre: "Extra", color: 0xFFE10F00, type: "Income"),
        CategoryModel(genre: "Transporte", color: 0xFFE6F201, type: "Expense"),
        CategoryModel(genre: "Freela", color: 0xFFE6F201, type: "Income"),
        CategoryModel(
            genre: "Entretenimento", color: 0xFF008614, type: "Expense"),
        CategoryModel(genre: "Reembolso", color: 0xFF008614, type: "Income"),
      ]);
    }

    return _dataList;
  }

  Future<List<CategoryModel>> add(CategoryModel categoryModel) async {
    await loadList();
    _dataList.add(categoryModel);
    await service.set(url: SharedPreferencesKeys.categorys, data: _dataList);
    return _dataList;
  }

  Future<List<CategoryModel>> remove(CategoryModel categoryModel) async {
    await loadList();
    _dataList.remove(categoryModel);
    await service.set(url: SharedPreferencesKeys.categorys, data: _dataList);
    return _dataList;
  }

  Future<List<CategoryModel>> edit(
      int index, CategoryModel categoryModel) async {
    await loadList();
    _dataList[index] = categoryModel;
    await service.set(url: SharedPreferencesKeys.categorys, data: _dataList);
    return _dataList;
  }
}
