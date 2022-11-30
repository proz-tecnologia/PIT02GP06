// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pit02gp06/models/category_model.dart';

abstract class CategoryEvent {}

class LoadCategoryEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  CategoryModel category;
  AddCategoryEvent({
    required this.category,
  });
}

class RemoveCategoryEvent extends CategoryEvent {
  CategoryModel category;
  RemoveCategoryEvent({
    required this.category,
  });
}

class EditCategoryEvent extends CategoryEvent {
  CategoryModel category;
  int index;
  EditCategoryEvent({
    required this.index,
    required this.category,
  });
}
