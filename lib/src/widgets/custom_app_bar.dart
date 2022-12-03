import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  String title;
  List<Widget>? actions;

  CustomAppBar({
    required this.title,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.grey1Color,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(30, 30))),
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }
}
