import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/page/login/login_screen.dart';

import '../../../repositories/fire_auth_repository.dart';
import '../../authentication_module/auth_repository.dart';
import '../../common/show_dialog.dart';

class LoginScreenController extends StatelessWidget {
  const LoginScreenController({super.key, FireAuthRepository? authRepository})
      : _authRepository = authRepository ?? const FireAuthRepository();

  final FireAuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (args != null && args is String) {
        showMyFDialog(context, args);
      }
    });

    return LoginScreen(
      onEnter: _onEnter,
      onRecover: () {},
      onCreateAccount: _onCreateAccount,
    );
  }

  Future<void> _onEnter(String email, String password) async {
    final authResult = await _authRepository.login(email, password);
    if (authResult?.success ?? false) {
      final user = await _authRepository.userByUid(authResult?.result);
      Modular.get<AuthRepository>().setUser(user!);

      Modular.to.pushReplacementNamed('/home');
    }
  }

  void _onCreateAccount() {
    Modular.to.pushReplacementNamed('/register');
  }
}
