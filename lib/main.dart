import 'package:flutter/material.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/src/category/category_page.dart';
import 'package:pit02gp06/src/home/home_page.dart';
import 'package:pit02gp06/src/page/base_screen.dart';
import 'package:pit02gp06/src/page/credit_card_register_screen.dart';
import 'package:pit02gp06/src/page/view_model/credit_card_register_view_model.dart';
import 'package:pit02gp06/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grupo 6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: CreditCardRegisterScreen(
          viewModel: CreditCardRegisterViewModel(),
          onRegister: (_) => print('REGISTRAR CLICADO'),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }
}
