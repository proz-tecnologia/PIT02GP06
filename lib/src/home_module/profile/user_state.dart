// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pit02gp06/models/user_model.dart';

abstract class UserState {}

class UserEmptyState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  UserModel user;
  UserSuccessState({
    required this.user,
  });
}

class UserErrorState extends UserState {
  String msg;
  UserErrorState({
    required this.msg,
  });
}
