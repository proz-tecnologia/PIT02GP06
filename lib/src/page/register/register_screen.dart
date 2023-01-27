import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pit02gp06/models/user_model.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';

import '../../../models/text_field_item.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/text_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    super.key,
    required this.onRegister,
    required this.onLogin,
  });

  final Function(UserModel, String) onRegister;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final phoneFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    final fullNameItem =
        TextFieldItem(label: 'Nome Completo', icon: Icons.person_outline);
    final phoneItem = TextFieldItem(
        label: 'Celular',
        icon: Icons.phone_outlined,
        formatter: [phoneFormatter],
        keyboardType: TextInputType.phone);
    final emailItem =
        TextFieldItem(label: 'E-mail', icon: Icons.email_outlined);
    final passwordItem = TextFieldItem(
        label: 'Senha', icon: Icons.lock_outline, isPassword: true);
    final repeatPasswordItem = TextFieldItem(
        label: 'Repetir Senha', icon: Icons.lock_outline, isPassword: true);

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
                padding: const EdgeInsets.symmetric(horizontal: 52),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          // TEXT "CRIE UMA CONTA"
                          Text('Crie uma conta',
                              style: AppTextStyles.textTitle2),
                          const SizedBox(height: 32),
                          // INPUT FULL NAME
                          TextFieldWidget(
                            item: fullNameItem,
                            borderColor: AppColors.grey4Color,
                          ),
                          const SizedBox(height: 8),
                          // INPUT PHONE
                          TextFieldWidget(
                            item: phoneItem,
                            borderColor: AppColors.grey4Color,
                          ),
                          const SizedBox(height: 8),
                          // INPUT EMAIL
                          TextFieldWidget(
                            item: emailItem,
                            borderColor: AppColors.grey4Color,
                          ),
                          const SizedBox(height: 8),
                          // INPUT PASSWORD 1
                          TextFieldWidget(
                            item: passwordItem,
                            borderColor: AppColors.grey4Color,
                          ),
                          const SizedBox(height: 8),
                          // INPUT PASSWORD 2
                          TextFieldWidget(
                            item: repeatPasswordItem,
                            borderColor: AppColors.grey4Color,
                          ),
                          const SizedBox(height: 16),
                          // BUTTON "CRIAR CONTA"
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => onRegister(
                                      UserModel(
                                          uid: '',
                                          name: fullNameItem.controller.text,
                                          email: emailItem.controller.text,
                                          phone: phoneItem.controller.text,
                                          balance: 0),
                                      passwordItem.controller.text),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(18),
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                  child: Text(
                                    'Criar conta',
                                    style: AppTextStyles.textButtonWidget,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: onLogin,
                            child: Text(
                              'Já sou cadastrado',
                              style: TextStyle(color: AppColors.blue5Color),
                            ),
                          ),
                        ],
                      ),
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
