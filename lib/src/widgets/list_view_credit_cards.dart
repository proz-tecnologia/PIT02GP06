import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/src/page/view_model/credit_card_register_view_model.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_formatter.dart';

import 'credit_card_widget.dart';

class ListViewCreditCards extends StatelessWidget {
  //TODO: implementar CreditCardController
  final List<CreditCardModel> listCreditCards = [
    CreditCardModel(
        uid: 'test',
        flag: 'master',
        nickname: 'nubank',
        limit: 3000.00,
        spent: 1300,
        closeDate: DateTime(2023, 01, 15),
        dueDate: DateTime(2023, 01, 20)),
    CreditCardModel(
        uid: 'test',
        flag: 'elo',
        nickname: 'caixa',
        limit: 1500.00,
        spent: 800,
        closeDate: DateTime(2023, 01, 2),
        dueDate: DateTime(2023, 01, 8)),
  ];
  ListViewCreditCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listCreditCards.length + 1,
          itemBuilder: ((context, index) {
            if (index < listCreditCards.length) {
              return CreditCardWidget(
                  apelido: listCreditCards[index].nickname,
                  valorAberto:
                      AppFormatter.moneyWithRs(listCreditCards[index].spent));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    var viewModel = CreditCardRegisterViewModel();
                    onRegister(CreditCardModel creditCardModel) {
                      //todo: call controller save function
                      log(creditCardModel.nickname);
                    }

                    Modular.to
                        .pushNamed('/home/credit_card_register', arguments: {
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
          })),
    );
  }
}
