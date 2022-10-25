import 'package:flutter/material.dart';

import 'credit_card_widget.dart';

class ListViewCreditCards extends StatelessWidget {
  const ListViewCreditCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
          CreditCardWidget(
            apelido: "Digio",
            valorAberto: "20,00",
            bandeira: "visa",
          ),
          CreditCardWidget(
            apelido: "De fora",
            valorAberto: "80,00",
            bandeira: "american",
          ),
          CreditCardWidget(
            apelido: "Itau",
            valorAberto: "80,00",
          ),
        ],
      ),
    );
  }
}
