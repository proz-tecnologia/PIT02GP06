import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  String title;
  List<Widget>? actions;
  bool leading;

  CustomAppBar({
    required this.title,
    this.actions,
    required this.leading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leading,
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.grey1Color,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(20, 20))),
      title: Text(title),
      centerTitle: true,
      actions: actions,
      shadowColor: const Color.fromARGB(40, 0, 0, 0),
    );
  }
}
