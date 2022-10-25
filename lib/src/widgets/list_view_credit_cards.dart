import 'package:flutter/material.dart';
import 'package:pit02gp06/utils/app_colors.dart';

import 'credit_card_widget.dart';

class ListViewCreditCards extends StatelessWidget {
  const ListViewCreditCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CreditCardWidget(
            apelido: "Nubank - virtual",
            valorAberto: "250,00",
            bandeira: "master",
          ),
          CreditCardWidget(
            apelido: "Caixa",
            valorAberto: "300,00",
            bandeira: "elo",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {},
              child: Icon(
                Icons.add,
                color: AppColors.grey2Color,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
