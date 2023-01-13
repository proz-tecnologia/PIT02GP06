// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pit02gp06/models/resume_model.dart';
import 'package:pit02gp06/models/user_model.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  ResumeModel resume;
  UserModel user;
  List<Map<String, Object>> listExpenseByCategory;
  HomeSuccessState({
    required this.resume,
    required this.user,
    required this.listExpenseByCategory,
  });
}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {}
