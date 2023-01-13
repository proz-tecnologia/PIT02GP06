import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/authentication/auth_repository.dart';
import 'package:pit02gp06/src/home/home_controller.dart';
import 'package:pit02gp06/src/home/home_state.dart';
import 'package:pit02gp06/src/widgets/balance_card.dart';
import 'package:pit02gp06/src/widgets/card_despesas_widget.dart';
import 'package:pit02gp06/src/widgets/header_user_card.dart';
import 'package:pit02gp06/src/widgets/list_view_credit_cards.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_formatter.dart';
import 'dart:developer';

import '../../models/user_model.dart';
import '../widgets/title_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    log(" medidas: ${MediaQuery.of(context).size.width} x ${MediaQuery.of(context).size.height}");

    return Column(
      children: [
//        HeaderUserCard(userName: "Fulano"),
        ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (context, value, child) {
            return HeaderUserCard(
              userName: value is HomeSuccessState ? value.user.name : '--',
            );
          },
        ),
        Expanded(
          child: ListView(
            children: [
              Icon(
                Icons.menu,
                color: AppColors.grey1Color,
              ),
              ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (context, value, child) {
                  return BalanceCard(
                    balance: value is HomeSuccessState
                        ? value.resume.balance.toStringAsFixed(2)
                        : "-.--",
                    income: value is HomeSuccessState
                        ? value.resume.income.toStringAsFixed(2)
                        : "-.--",
                    spend: value is HomeSuccessState
                        ? value.resume.spend.toStringAsFixed(2)
                        : "-.--",
                  );
                },
              ),
              TitleWidget(title: "Cartões de Crédito"),
              ListViewCreditCards(),
              TitleWidget(title: "Despesas"),
              ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (context, value, child) {
                  return value is HomeSuccessState
                      ? value.listExpenseByCategory.length >= 2
                          ? CardDespesasWidget(
                              data: value.listExpenseByCategory,
                            )
                          : Card(
                              elevation: 4,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child:
                                  Text('Sem dados suficientes para gráficos!'),
                            )
                      : Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: LinearProgressIndicator(),
                        );
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
