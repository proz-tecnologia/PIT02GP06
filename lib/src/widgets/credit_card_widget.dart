import 'package:flutter/material.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_formatter.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';
import 'package:pit02gp06/utils/credit_card_brand.dart';

// ignore: must_be_immutable
class CreditCardWidget extends StatelessWidget {
  final CreditCardModel creditCard;
  final today = DateTime.now();
  CreditCardWidget({
    super.key,
    required this.creditCard,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: AppColors.blue1Color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    creditCard.flag,
                    style: AppTextStyles.textCreditCard,
                  ),
                  CreditBrand.brandIcon(
                      flag: creditCard.flag, color: AppColors.whiteColor),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "fecha ${creditCard.closeDate.day}, vence ${creditCard.dueDate.day}",
                    style: AppTextStyles.textCreditCard,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    AppFormatter.moneyWithRs(creditCard.spent),
                    style: AppTextStyles.textCreditCardValueBalance,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    creditCard.nickname,
                    style: AppTextStyles.textCreditCard,
                  ),
                  Icon(
                    Icons.menu,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
