import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/page/intro/intro_screen.dart';

class IntroScreenController extends StatelessWidget {
  const IntroScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      onCreateAccount: () => Modular.to.pushNamed('/register'),
      onRegistered: () => Modular.to.pushNamed('/login'),
    );
  }
}
