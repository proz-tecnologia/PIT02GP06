import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

// ignore: must_be_immutable
class HeaderUserCard extends StatelessWidget {
  String userName;
  HeaderUserCard({
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: AppColors.whiteColor,
      width: MediaQuery.of(context).size.width,
      height: 130,

      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.elliptical(30, 30))),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color.fromARGB(255, 237, 236, 236),
                  foregroundColor: AppColors.grey2Color,
                  child: const Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Olá",
                      style: AppTextStyles.textHello,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userName,
                      style: AppTextStyles.textName,
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.notifications,
              size: 40,
              color: AppColors.grey2Color,
            ),
          ],
        ),
      )),
    );
  }
}
