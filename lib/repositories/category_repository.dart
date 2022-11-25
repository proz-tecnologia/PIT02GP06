import 'dart:convert';
import 'dart:developer';

import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/utils/i_http_service.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';

class CategoryRepository {
  final IHttpService service;
  final List<CategoryModel> _categoryList = [];
  CategoryRepository({required this.service});
  List<CategoryModel> loadList() {
    _categoryList.addAll([
      CategoryModel(genre: "Lazer", color: 0xFF5A41FF, type: "expense"),
      CategoryModel(genre: "Casa", color: 0xFFE10F00, type: "expense"),
      CategoryModel(genre: "Transporte", color: 0xFFE6F201, type: "expense"),
      CategoryModel(genre: "Outros", color: 0xFF0F0297, type: "expense"),
    ]);
    return _categoryList;
  }

  List<CategoryModel> add(CategoryModel categoryModel) {
    _categoryList.add(categoryModel);
    return _categoryList;
  }

  List<CategoryModel> remove(CategoryModel categoryModel) {
    _categoryList.remove(categoryModel);
    return _categoryList;
  }
}
