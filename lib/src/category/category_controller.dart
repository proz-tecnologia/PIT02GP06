import 'package:flutter/foundation.dart';
import 'package:pit02gp06/utils/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/category_model.dart';
import '../../repositories/category_repository.dart';
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

    _repository = CategoryRepository(
        service: SharedPreferencesService(instance: instance));
    List<CategoryModel> categoryList = await _repository.loadList();
    state.value = CategorySuccessState(categoryList: categoryList);
  }

  void delete(int index) async {
    state.value = CategoryLoadState();
    List<CategoryModel> list = await _repository.remove(index);
    //List<CategoryModel> list = await _repository.loadList();
    state.value = CategorySuccessState(categoryList: list);
  }

  void add(CategoryModel category) async {
    state.value = CategoryLoadState();
    List<CategoryModel> list = await _repository.add(category);
    // List<CategoryModel> list = await _repository.loadList();
    state.value = CategorySuccessState(categoryList: list);
  }

  void edit(int index, CategoryModel category) async {
    state.value = CategoryLoadState();
    List<CategoryModel> list = await _repository.edit(index, category);
    //List<CategoryModel> list = await _repository.loadList();
    state.value = CategorySuccessState(categoryList: list);
  }
}
