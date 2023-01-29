import 'package:flutter/material.dart';
import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/src/widgets/text_field_widget.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen(
      {super.key,
      required this.onEnter,
      required this.onRecover,
      required this.onCreateAccount});

  final Function(String, String) onEnter;
  final VoidCallback onRecover;
  final VoidCallback onCreateAccount;

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
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(52.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
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
                                    padding: const EdgeInsets.all(12),
                                    backgroundColor: Colors.black,
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
                          child: Text(
                            'Recuperar senha',
                            style: TextStyle(color: AppColors.blue5Color),
                          ),
                        ),
                        TextButton(
                          onPressed: onCreateAccount,
                          child: Text(
                            'Criar uma conta',
                            style: TextStyle(color: AppColors.blue5Color),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
