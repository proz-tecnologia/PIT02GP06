import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../models/credit_card_model.dart';
import '../../../utils/app_colors.dart';
import '../../page/view_model/credit_card_register_view_model.dart';
import 'credit_card_controller.dart';

class AddCreditCardButton extends StatelessWidget {
  AddCreditCardButton({
    Key? key,
  }) : super(key: key);

  final _controller = Modular.get<CreditCardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          var viewModel = CreditCardRegisterViewModel();
          onRegister(CreditCardModel creditCardModel) {
            _controller.save(creditCardModel);
          }

          Modular.to.pushNamed('/home/credit_card_register', arguments: {
            'viewModel': viewModel,
            'onRegister': onRegister,
          });
        },
        child: Icon(
          Icons.add,
          color: AppColors.grey2Color,
          size: 50,
        ),
      ),
    );
  }
}
