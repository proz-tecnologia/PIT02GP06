// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pit02gp06/models/user_model.dart';

abstract class SplashState {}

class SplashStateInitial extends SplashState {}

class SplashStateLoading extends SplashState {}

class SplashStateAuthenticated extends SplashState {
  UserModel user;
  SplashStateAuthenticated({
    required this.user,
  });
}

class SplashStateUnauthenticated extends SplashState {}

class SplashStateError extends SplashState {
  String errorMsg;
  SplashStateError({
    required this.errorMsg,
  });
}
