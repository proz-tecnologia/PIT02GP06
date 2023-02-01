import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';

class ButtonCountSelect extends StatelessWidget {
  final Function selectCreditCard;
  const ButtonCountSelect({
    Key? key,
    required this.selectCreditCard,
    required String? selectedCreditCard,
  })  : _selectedCreditCard = selectedCreditCard,
        super(key: key);

  final String? _selectedCreditCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: GestureDetector(
        onTap: () {
          selectCreditCard(null);
        },
        child: Card(
          color: _selectedCreditCard == null
              ? AppColors.red1Color
              : AppColors.chipGreyColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'À vista',
                style: _selectedCreditCard == null
                    ? AppTextStyles.textChipSelected
                    : AppTextStyles.textChip,
              ),
              Text(
                'Conta',
                style: _selectedCreditCard == null
                    ? AppTextStyles.textChipSelected
                    : AppTextStyles.textChip,
              ),
              Icon(
                Icons.attach_money,
                color: _selectedCreditCard == null
                    ? AppColors.whiteColor
                    : AppColors.grey2Color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
