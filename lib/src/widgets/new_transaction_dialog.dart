import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

Future<String?> showNewTransactionDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Incluir uma"),
          content: Row(children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "Income");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue1Color,
                  fixedSize: Size(MediaQuery.of(context).size.width / 3, 200),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.elliptical(80, 80))),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Receita",
                      style: AppTextStyles.textCreditCardValueBalance,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.monetization_on,
                      size: 50,
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "Expense");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red1Color,
                  fixedSize: Size(MediaQuery.of(context).size.width / 3, 200),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.elliptical(80, 80))),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Despesa",
                      style: AppTextStyles.textCreditCardValueBalance,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.money_off_csred,
                      size: 50,
                    ),
                  ],
                ))
          ]),
        );
      });
}
