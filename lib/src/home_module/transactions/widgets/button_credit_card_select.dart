import 'package:flutter/material.dart';
import 'package:pit02gp06/models/credit_card_model.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/credit_card_brand.dart';

class ButtonCreditCardSelect extends StatelessWidget {
  Function selectCreditCard;
  ButtonCreditCardSelect({
    Key? key,
    required this.creditCard,
    required this.selectCreditCard,
    required String? selectedCreditCard,
  })  : _selectedCreditCard = selectedCreditCard,
        super(key: key);

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
              CreditBrand.brandIcon(creditCard.flag),
            ],
          ),
        ),
      ),
    );
  }
}
