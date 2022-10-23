import 'package:flutter/material.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: AppColors.backgroundColor),
    );
  }
}
