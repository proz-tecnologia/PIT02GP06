import 'package:flutter/material.dart';
import 'package:pit02gp06/src/home_module/category/category_controller.dart';
import 'package:pit02gp06/src/home_module/transactions/transactions_controller.dart';
import 'package:pit02gp06/utils/app_colors.dart';

import '../../models/transaction_model.dart';
import '../home_module/transactions/form_transaction_page.dart';
import 'new_transaction_dialog.dart';

class BottomNavBar extends StatefulWidget {
  final PageController pageController;
  final TransactionsController transactionsController;
  final CategoryController categoryController;
  const BottomNavBar(
      {super.key,
      required this.pageController,
      required this.transactionsController,
      required this.categoryController});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    void changeIndex(value) {
      setState(() {
        widget.pageController.jumpToPage(value);
        index = value;
      });
    }

    return Container(
      width: size.width,
      height: 70,
      color: AppColors.whiteColor,
      child: Stack(
        children: [
          CustomPaint(size: Size(size.width, 80)),
          Center(
            heightFactor: 0.5,
            child: FloatingActionButton(
              onPressed: () async {
                String? type = await showNewTransactionDialog(context);
                if (type != null) {
                  await Navigator.of(context)
                      .push<TransactionModel?>(MaterialPageRoute(
                          builder: (context) => FormTransactionPage(
                                type: type,
                                categoryController: widget.categoryController,
                                transactionController:
                                    widget.transactionsController,
                              )));
                }
              },
              backgroundColor: AppColors.blue1Color,
              child: const Icon(Icons.add),
            ),
          ),
          SizedBox(
            width: size.width,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      changeIndex(0);
                    },
                    icon: const Icon(Icons.home),
                    color: index == 0
                        ? AppColors.blue1Color
                        : AppColors.grey1Color,
                    tooltip: 'Principal',
                    // isSelected: ,
                  ),
                  IconButton(
                    onPressed: () {
                      changeIndex(1);
                    },
                    icon: const Icon(Icons.change_circle),
                    color: index == 1
                        ? AppColors.blue1Color
                        : AppColors.grey1Color,
                    tooltip: 'Transações',
                  ),
                  Container(
                    width: size.width * 0.10,
                  ),
                  IconButton(
                    onPressed: () {
                      changeIndex(2);
                    },
                    icon: const Icon(Icons.list),
                    color: index == 2
                        ? AppColors.blue1Color
                        : AppColors.grey1Color,
                    tooltip: 'Detalhes',
                  ),
                  IconButton(
                    onPressed: () {
                      changeIndex(3);
                    },
                    icon: const Icon(Icons.person_outline),
                    color: index == 3
                        ? AppColors.blue1Color
                        : AppColors.grey1Color,
                    tooltip: 'Perfil',
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
