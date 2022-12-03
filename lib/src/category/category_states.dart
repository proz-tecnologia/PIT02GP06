// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pit02gp06/models/category_model.dart';

abstract class CategoryState {
  List<CategoryModel> categoryList;
  CategoryState({
    required this.categoryList,
  });
}

class CategoryInitialState extends CategoryState {
  CategoryInitialState() : super(categoryList: []);
}

class CategorySuccessState extends CategoryState {
  CategorySuccessState({required super.categoryList});
}
