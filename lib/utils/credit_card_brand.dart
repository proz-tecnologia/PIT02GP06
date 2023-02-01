import 'package:flutter/material.dart';

class CreditBrand {
  static Widget brandIcon(String flag) {
    Widget iconBandeira;
    final mapBrands = {
      "Mastercard": "master",
      "Visa": "visa",
      "Elo": "elo",
      "American Express": "american",
    };
    switch (flag) {
      case "Mastercard":
      case "Visa":
      case "Elo":
      case "American Express":
        iconBandeira =
            Image.asset("lib/images/${mapBrands[flag]}.png", height: 16);
        break;
      default:
        {
          iconBandeira = const Icon(
            Icons.credit_card,
            size: 20,
          );
        }
    }
    return iconBandeira;
  }
}
