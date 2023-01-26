import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/src/home_module/credit_card/credit_card_controller.dart';
import 'package:pit02gp06/src/home_module/credit_card/credit_card_state.dart';
import 'package:pit02gp06/src/page/view_model/credit_card_register_view_model.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_formatter.dart';

import '../home_module/credit_card/add_credit_card_button.dart';
import 'credit_card_widget.dart';

class ListViewCreditCards extends StatefulWidget {
  ListViewCreditCards({
    Key? key,
  }) : super(key: key);

  @override
  State<ListViewCreditCards> createState() => _ListViewCreditCardsState();
}

class _ListViewCreditCardsState extends State<ListViewCreditCards> {
  final _controller = Modular.get<CreditCardController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ValueListenableBuilder(
        valueListenable: _controller.state,
        builder: (context, value, child) {
          switch (value.runtimeType) {
            case CreditCardLoadState:
              return Card(
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.backgroundColor,
                  color: AppColors.whiteColor,
                ),
              );
            case CreditCardSuccessState:
              final listCreditCards = (value as CreditCardSuccessState).list;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCreditCards.length + 1,
                  itemBuilder: ((context, index) {
                    if (index < listCreditCards.length) {
                      return CreditCardWidget(
                          creditCard: listCreditCards[index]);
                    } else {
                      return AddCreditCardButton();
                    }
                  }));

            default:
              return AddCreditCardButton();
          }
        },
      ),
    );
  }
}
