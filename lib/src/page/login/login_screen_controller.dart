import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/repositories/fire_user_repository.dart';
import 'package:pit02gp06/src/page/login/login_screen.dart';

import '../../../repositories/fire_auth_repository.dart';
import '../../authentication_module/auth_repository.dart';

class LoginScreenController extends StatelessWidget {
  const LoginScreenController(
      {super.key,
      FireAuthRepository? authRepository,
      FireUserRepository? userRepository})
      : _authRepository = authRepository ?? const FireAuthRepository(),
        _userRepository = userRepository ?? const FireUserRepository();

  final FireAuthRepository _authRepository;
  final FireUserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return LoginScreen(onEnter: _onEnter, onRecover: () {});
  }

  Future<void> _onEnter(String email, String password) async {
    final authResult = await _authRepository.login(email, password);
    if (authResult?.success ?? false) {
      final user = await _userRepository.byUid(authResult?.result);
      Modular.get<AuthRepository>().setUser(user!);

      Modular.to.pushReplacementNamed('/home');
    }
  }
}
