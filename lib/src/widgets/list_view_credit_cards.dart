import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/home_module/credit_card/credit_card_controller.dart';
import 'package:pit02gp06/src/home_module/credit_card/credit_card_state.dart';
import 'package:pit02gp06/src/widgets/custom_loading_widget.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import '../home_module/credit_card/add_credit_card_button.dart';
import 'credit_card_widget.dart';

class ListViewCreditCards extends StatefulWidget {
  const ListViewCreditCards({
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
              return const Card(
                child: CustomRectangularLoading(
                    height: 100, width: 100, radius: 30),
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
