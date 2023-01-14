import 'package:flutter/material.dart';
import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/src/widgets/text_field_widget.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.onEnter,
    required this.onRecover,
  });

  final Function(String, String) onEnter;
  final VoidCallback onRecover;

  @override
  Widget build(BuildContext context) {
    final emailItem = TextFieldItem(
      label: 'Email',
      icon: Icons.email_outlined,
    );
    final passwordItem = TextFieldItem(
      label: 'Senha',
      icon: Icons.lock_outline,
      isPassword: true,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: AppColors.secondaryColor,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(52.0),
          child: Column(
            children: [
              const Text(
                'Acesse sua conta',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 32),
              TextFieldWidget(
                item: emailItem,
              ),
              const SizedBox(height: 8),
              TextFieldWidget(
                item: passwordItem,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onEnter(
                        emailItem.controller.text,
                        passwordItem.controller.text,
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: onRecover,
                child: const Text('Recuperar senha'),
              ),
              const SizedBox(height: 20),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
