import 'dart:async';

import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/repositories/category_repository.dart';
import 'package:pit02gp06/src/category/category_events.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/shared_preferences_service.dart';

class CategoryBloc {
  late CategoryRepository _repository;
  final StreamController<CategoryEvent> _inputCategoryController =
      StreamController<CategoryEvent>();
  final StreamController<CategoryState> _outputCategoryController =
      StreamController<CategoryState>();
  Sink<CategoryEvent> get inputCategory => _inputCategoryController.sink;
  Stream<CategoryState> get stream => _outputCategoryController.stream;

  CategoryBloc() {
    _inputCategoryController.stream.listen(_mapEventToState);
  }

  init() async {
    final instance = await SharedPreferences.getInstance();
    _repository = CategoryRepository(
        service: SharedPreferencesService(instance: instance));
  }

  _mapEventToState(CategoryEvent event) async {
    await init();
    List<CategoryModel> categoryList = [];
    if (event is LoadCategoryEvent) {
      categoryList = _repository.loadList();
    } else if (event is AddCategoryEvent) {
      categoryList = _repository.add(event.category);
    } else if (event is RemoveCategoryEvent) {
      categoryList = _repository.remove(event.category);
    }
    _outputCategoryController
        .add(CategorySuccessState(categoryList: categoryList));
  }
}
