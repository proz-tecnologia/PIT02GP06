import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/user_model.dart';
import 'package:pit02gp06/src/authentication_module/auth_repository.dart';
import 'package:pit02gp06/src/home_module/profile/user_state.dart';

class UserController {
  final state = ValueNotifier<UserState>(UserEmptyState());
  UserController() {
    init();
  }

  init() async {
    state.value = UserLoadingState();
    await Future.delayed(const Duration(seconds: 1));
    final user = await Modular.get<AuthRepository>().getUser();
    state.value = UserSuccessState(user: user);
  }

  Future<void> save(UserModel user) async {
    state.value = UserLoadingState();
    await Future.delayed(const Duration(seconds: 1));
    final authRepo = Modular.get<AuthRepository>();
    authRepo.setUser(user);
    state.value = UserSuccessState(user: user);
  }
}
