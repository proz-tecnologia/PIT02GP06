import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/home_module/home/home_controller.dart';
import 'package:pit02gp06/src/home_module/home/home_state.dart';
import 'package:pit02gp06/src/widgets/balance_card.dart';
import 'package:pit02gp06/src/widgets/card_despesas_widget.dart';
import 'package:pit02gp06/src/widgets/custom_loading_widget.dart';
import 'package:pit02gp06/src/widgets/header_user_card.dart';
import 'package:pit02gp06/src/widgets/list_view_credit_cards.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';
import '../../widgets/title_widget.dart';
import '../credit_card/credit_card_controller.dart';
import '../profile/user_controller.dart';
import '../transactions/transactions_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Modular.get<HomeController>();
  Future<void> _refresh() async {
    Modular.get<TransactionsController>().init();
    Modular.get<CreditCardController>().init();
    Modular.get<UserController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderUserCard(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
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
                const ListViewCreditCards(),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Dados insuficientes para apresentação gráfica!',
                                    style: AppTextStyles.textBalance,
                                  ),
                                ),
                              )
                        : Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const CustomRectangularLoading(
                                height: 160, width: 100, radius: 30),
                          );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
