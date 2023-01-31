import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomCircularLoading extends StatelessWidget {
  final double size;
  const CustomCircularLoading({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: SizedBox(
        height: size,
        width: size,
        child: LinearProgressIndicator(
          backgroundColor: AppColors.backgroundColor,
          color: AppColors.linearProgressColor,
        ),
      ),
    );
  }
}

class CustomRectangularLoading extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  const CustomRectangularLoading({
    Key? key,
    required this.height,
    required this.width,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: SizedBox(
        height: height,
        width: width,
        child: LinearProgressIndicator(
          backgroundColor: AppColors.backgroundColor,
          color: AppColors.linearProgressColor,
        ),
      ),
    );
  }
}
