import 'package:pit02gp06/models/credit_card_model.dart';

abstract class CreditCardState {}

class CreditCardLoadState extends CreditCardState {}

class CreditCardSuccessState extends CreditCardState {
  final List<CreditCardModel> list;

  CreditCardSuccessState({required this.list});
}

class CreditCardEmptyState extends CreditCardState {}

class CreditCardErrorState extends CreditCardState {}
