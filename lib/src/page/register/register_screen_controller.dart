import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/page/register/register_screen.dart';

import '../../../repositories/fire_auth_repository.dart';

class RegisterScreenController extends StatelessWidget {
  const RegisterScreenController(
      {super.key, FireAuthRepository? authRepository})
      : _authRepository = authRepository ?? const FireAuthRepository();

  final FireAuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RegisterScreen(
      onLogin: () {},
      onRegister: (user, password) async {
        final result = await _authRepository.register(user, password);
        if (result?.success ?? false) {
          Modular.to.pushReplacementNamed('/login');
        }
      },
    );
  }
}
