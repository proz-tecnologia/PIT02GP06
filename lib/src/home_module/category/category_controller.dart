import 'package:flutter/foundation.dart';
import 'package:pit02gp06/utils/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/category_model.dart';
import '../../../repositories/category_repository.dart';
import 'category_states.dart';

class CategoryController {
  ValueNotifier<CategoryState> state = ValueNotifier(CategoryEmptyState());
  late final CategoryRepository _repository;
//  final instance;

  CategoryController() {
    state.value = CategoryLoadState();
    init();
  }
  void init() async {
    final instance = await SharedPreferences.getInstance();

    _repository = CategoryRepository();
    List<CategoryModel> categoryList = await _repository.loadList();
    state.value = CategorySuccessState(categoryList: categoryList);
  }

  void delete(String id) async {
    state.value = CategoryLoadState();
    await _repository.delete(id);
    List<CategoryModel> list = await _repository.loadList();
    state.value = CategorySuccessState(categoryList: list);
  }

  void save(CategoryModel category) async {
    state.value = CategoryLoadState();
    await _repository.save(category);
    List<CategoryModel> list = await _repository.loadList();
    state.value = CategorySuccessState(categoryList: list);
  }

  void incrementCount(String categoryId) async {
    final category = await _repository.loadDoc(categoryId);
    category.incrementCount();
    save(category);
  }

  void decrementCount(String categoryId) async {
    final category = await _repository.loadDoc(categoryId);
    category.decrementCount();
    save(category);
  }
}
