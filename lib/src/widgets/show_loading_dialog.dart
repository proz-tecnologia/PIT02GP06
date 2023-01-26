import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

Future<dynamic> showLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppColors.blue1Color,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Aguarde...',
                  style: AppTextStyles.textHello,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
