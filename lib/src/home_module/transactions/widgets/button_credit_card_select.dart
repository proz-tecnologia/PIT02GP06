import 'package:flutter/material.dart';
import 'package:pit02gp06/models/credit_card_model.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';

class ButtonCreditCardSelect extends StatelessWidget {
  final mapBrands = {
    "master": "Mastercard",
    "visa": "Visa",
    "elo": "Elo",
    "american": "American Express",
    "outro": "Outro",
  };
  Function selectCreditCard;
  late Widget iconBandeira;
  ButtonCreditCardSelect({
    Key? key,
    required this.creditCard,
    required this.selectCreditCard,
    required String? selectedCreditCard,
  })  : _selectedCreditCard = selectedCreditCard,
        super(key: key) {
    switch (creditCard.flag) {
      case "master":
      case "visa":
      case "elo":
      case "american":
        iconBandeira = Image.asset(
          "lib/images/${creditCard.flag}.png",
          height: 16,
          color: _selectedCreditCard == creditCard.id
              ? AppColors.whiteColor
              : AppColors.grey2Color,
        );
        break;
      default:
        {
          iconBandeira = Icon(
            Icons.credit_card,
            color: AppColors.whiteColor,
            size: 20,
          );
        }
    }
  }

  final String? _selectedCreditCard;
  final CreditCardModel creditCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: GestureDetector(
        onTap: () {
          selectCreditCard(creditCard.id);
        },
        child: Card(
          color: _selectedCreditCard == creditCard.id
              ? AppColors.red1Color
              : AppColors.chipGreyColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Crédito'),
              Text(
                creditCard.nickname,
                style: _selectedCreditCard == creditCard.id
                    ? AppTextStyles.textChipSelected
                    : AppTextStyles.textChip,
              ),
              iconBandeira,
            ],
          ),
        ),
      ),
    );
  }
}
