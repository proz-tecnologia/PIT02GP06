import 'package:flutter/material.dart';
import 'package:pit02gp06/src/widgets/balance_card.dart';
import 'package:pit02gp06/src/widgets/card_despesas_widget.dart';
import 'package:pit02gp06/src/widgets/header_user_card.dart';
import 'package:pit02gp06/src/widgets/list_view_credit_cards.dart';
import 'dart:developer';

import '../widgets/title_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log(" medidas: ${MediaQuery.of(context).size.width} x ${MediaQuery.of(context).size.height}");

    return Column(
      children: [
        HeaderUserCard(userName: "Fulano"),
        Expanded(
          child: ListView(
            children: [
              BalanceCard(balance: "300", income: "1000", spend: "700"),
              TitleWidget(title: "Cartões de Crédito"),
              ListViewCreditCards(),
              TitleWidget(title: "Despesas"),
              CardDespesasWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
