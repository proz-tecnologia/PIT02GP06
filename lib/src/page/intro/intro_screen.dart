import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({
    super.key,
    required this.onCreateAccount,
    required this.onRegistered,
  });

  final VoidCallback onCreateAccount;
  final VoidCallback onRegistered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/logo.png',
                height: 110,
              ),
              Image.asset(
                'lib/images/cards.png',
                height: 200,
              ),
              const SizedBox(height: 16),
              Divider(
                color: AppColors.grey2Color,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'A ferramenta mais prática para te ajudar a gerir o seu dinheiro e alcançar seus objetivos!',
                  style: AppTextStyles.textIntro,
                ),
              ),
              Divider(
                color: AppColors.grey2Color,
                thickness: 0.5,
              ),
              const SizedBox(height: 32),
              Container(
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: AppColors.secondaryColor),
                child: ListTile(
                    onTap: onCreateAccount,
                    title: Text(
                      'Criar uma conta',
                      style: AppTextStyles.textButtonWidget,
                    ),
                    trailing: const Icon(
                      Icons.arrow_circle_right,
                      color: Colors.white,
                      size: 35,
                    )),
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: onRegistered,
                child: Text(
                  'Já sou cadastrado',
                  style: AppTextStyles.textRecoverPassword,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
