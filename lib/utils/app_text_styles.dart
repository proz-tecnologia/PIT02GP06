import 'package:flutter/material.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class AppTextStyles {
  static TextStyle get textHello =>
      TextStyle(fontSize: 40, color: AppColors.primaryColor);
  static TextStyle get textTitle =>
      TextStyle(fontSize: 50, color: AppColors.grey1Color);
  static TextStyle get textOfDropDown =>
      TextStyle(fontSize: 50, color: AppColors.primaryColor);
  static TextStyle get textBalance => // Saldo, Receitas e Despesas
      TextStyle(fontSize: 40, color: AppColors.grey1Color);
  static TextStyle get textValueBalance => // Valor do saldo
      TextStyle(fontSize: 50, color: AppColors.grey1Color);
  static TextStyle get textValueIncome =>
      TextStyle(fontSize: 40, color: AppColors.secondaryColor);
  static TextStyle get textValueExpense =>
      TextStyle(fontSize: 40, color: AppColors.red1Color);
  static TextStyle get textNotRegistered =>
      TextStyle(fontSize: 35, color: AppColors.grey1Color);
}
