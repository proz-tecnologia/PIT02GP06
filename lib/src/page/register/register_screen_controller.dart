import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/page/register/register_screen.dart';

import '../../../repositories/fire_auth_repository.dart';
import '../../common/show_dialog.dart';

class RegisterScreenController extends StatelessWidget {
  const RegisterScreenController(
      {super.key, FireAuthRepository? authRepository})
      : _authRepository = authRepository ?? const FireAuthRepository();

  final FireAuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RegisterScreen(
      onLogin: _onLogin,
      onRegister: (user, password) async {
        final result = await _authRepository.register(user, password);

        if (result?.success ?? false) {
          Modular.to.pushReplacementNamed('/login',
              arguments: 'Usuário criado com sucesso!');
        } else {
          // ignore: use_build_context_synchronously
          showMyFDialog(context, result?.error);
        }
      },
    );
  }

  void _onLogin() {
    Modular.to.pushReplacementNamed('/login');
  }
}
