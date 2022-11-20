import 'package:flutter/material.dart';
import 'package:pit02gp06/src/widgets/button_secondary.dart';
import 'package:pit02gp06/src/widgets/button_widget.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'My-F',
              style: AppTextStyles.textBrand,
            ),
            Text(
              'A ferramenta mais prática para te ajudar a gerir o seu dinheiro e alcançar seus objetivos!',
              style: AppTextStyles.textIntro,
            ),
            ButtonWidget(
              text: 'Criar uma conta',
              color: AppColors.secondaryColor,
            ),
            ButtonSecondary(
              text: 'Já sou cadastrado',
              style: AppTextStyles.textButtonSecondaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
