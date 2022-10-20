import 'package:flutter/material.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class AppTextStyles {
  static TextStyle get textHello =>
      TextStyle(fontSize: 40, color: AppColors.primaryColor);
  static TextStyle get textTitle =>
      TextStyle(fontSize: 50, color: AppColors.textColor);
  static TextStyle get textOfDropDown =>
      TextStyle(fontSize: 50, color: AppColors.primaryColor);
  static TextStyle get textBalance =>
      TextStyle(fontSize: 40, color: AppColors.textColor);
  static TextStyle get textValueBalance =>
      TextStyle(fontSize: 50, color: AppColors.textColor);
  static TextStyle get textTitleIncomeAndExpense =>
      TextStyle(fontSize: 50, color: AppColors.textColor);
  static TextStyle get textValueIncome =>
      TextStyle(fontSize: 40, color: AppColors.textValueIncome);
  static TextStyle get textValueExpense =>
      TextStyle(fontSize: 40, color: AppColors.textValueExpense);
  static TextStyle get textNotRegistered =>
      TextStyle(fontSize: 35, color: AppColors.textColor);
}
