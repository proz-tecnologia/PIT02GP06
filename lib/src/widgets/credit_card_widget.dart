import 'package:flutter/material.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';

class CreditCardWidget extends StatelessWidget {
  final mapBrands = {
    "master": "Mastercard",
    "visa": "Visa",
    "elo": "Elo",
    "american": "American Express",
    "outro": "Outro",
  };
  String bandeira = "";
  String apelido;
  String valorAberto;
  var iconBandeira;
  CreditCardWidget(
      {super.key,
      required this.apelido,
      required this.valorAberto,
      this.bandeira = ""}) {
    switch (bandeira) {
      case "master":
      case "visa":
      case "elo":
      case "american":
        iconBandeira = Image.asset("lib/images/$bandeira.png", height: 12);
        break;
      default:
        {
          iconBandeira = Icon(
            Icons.credit_card,
            color: AppColors.whiteColor,
            size: 18,
          );
          bandeira = "outro";
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.blue1Color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mapBrands[bandeira]!,
                    style: AppTextStyles.textCreditCard,
                  ),
                  iconBandeira,
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fatura em aberto",
                    style: AppTextStyles.textCreditCard,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "R\$ $valorAberto",
                    style: AppTextStyles.textCreditCardValueBalance,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    apelido,
                    style: AppTextStyles.textCreditCard,
                  ),
                  Icon(
                    Icons.menu,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
