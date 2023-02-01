import 'package:flutter/material.dart';
import 'package:pit02gp06/src/widgets/custom_app_bar.dart';
import 'package:pit02gp06/src/widgets/title_widget.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_formatter.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: 'Detalhes', leading: false),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  TitleWidget(title: "Saldo"),
                  Card(
                    child: SizedBox(
                      height: 100,
                      width: size.width * 0.96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.account_balance,
                                  color: AppColors.grey2Color),
                              Icon(Icons.attach_money,
                                  color: AppColors.grey2Color),
                              Icon(Icons.money_off,
                                  color: AppColors.grey2Color),
                            ],
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Conta: ', style: AppTextStyles.textBalance),
                              Text('Receitas: ',
                                  style: AppTextStyles.textBalance),
                              Text(
                                'Despesas: ',
                                style: AppTextStyles.textBalance,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AppFormatter.moneyWithRs(200.99),
                                style: AppTextStyles.textBalance,
                              ),
                              Text(
                                AppFormatter.moneyWithRs(300.99),
                                style: AppTextStyles.textBalance,
                              ),
                              Text(
                                AppFormatter.moneyWithRs(100.00),
                                style: AppTextStyles.textBalance,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TitleWidget(title: "Crédito"),
                  Card(
                    child: SizedBox(
                      height: 100,
                      width: size.width * 0.96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.credit_card,
                                  color: AppColors.grey2Color),
                              Icon(Icons.credit_card_off_outlined,
                                  color: AppColors.grey2Color),
                              Icon(Icons.credit_score,
                                  color: AppColors.grey2Color),
                            ],
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Limite total: ',
                                  style: AppTextStyles.textBalance),
                              Text('Utilizado: ',
                                  style: AppTextStyles.textBalance),
                              Text(
                                'Disponível: ',
                                style: AppTextStyles.textBalance,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AppFormatter.moneyWithRs(3000),
                                style: AppTextStyles.textBalance,
                              ),
                              Text(
                                AppFormatter.moneyWithRs(1000),
                                style: AppTextStyles.textBalance,
                              ),
                              Text(
                                AppFormatter.moneyWithRs(2000),
                                style: AppTextStyles.textBalance,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TitleWidget(title: "Contas a pagar"),
                  Card(
                    child: SizedBox(
                      height: 100,
                      width: size.width * 0.96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.today, color: AppColors.grey2Color),
                              Icon(Icons.info_outline,
                                  color: AppColors.grey2Color),
                              Icon(Icons.attach_money,
                                  color: AppColors.grey2Color),
                            ],
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Vencimento: ',
                                  style: AppTextStyles.textBalance),
                              Text('Tipo: ', style: AppTextStyles.textBalance),
                              Text(
                                'Valor: ',
                                style: AppTextStyles.textBalance,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '18/02',
                                style: AppTextStyles.textBalance,
                              ),
                              Text(
                                'Fatura',
                                style: AppTextStyles.textBalance,
                              ),
                              Text(
                                AppFormatter.moneyWithRs(1000),
                                style: AppTextStyles.textBalance,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: SizedBox(
                      height: 100,
                      width: size.width * 0.96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.today, color: AppColors.grey2Color),
                              Icon(Icons.info_outline,
                                  color: AppColors.grey2Color),
                              Icon(Icons.attach_money,
                                  color: AppColors.grey2Color),
                            ],
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Vencimento: ',
                                  style: AppTextStyles.textBalance),
                              Text('Tipo: ', style: AppTextStyles.textBalance),
                              Text(
                                'Valor: ',
                                style: AppTextStyles.textBalance,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '30/02',
                                style: AppTextStyles.textBalance,
                              ),
                              Text(
                                'Conta Internet',
                                style: AppTextStyles.textBalance,
                              ),
                              Text(
                                AppFormatter.moneyWithRs(150),
                                style: AppTextStyles.textBalance,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
