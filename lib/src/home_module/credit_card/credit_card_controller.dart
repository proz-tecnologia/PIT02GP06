import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/credit_card_model.dart';
import 'package:pit02gp06/repositories/credit_card_repository.dart';
import 'package:pit02gp06/src/home_module/credit_card/credit_card_state.dart';

class CreditCardController {
  ValueNotifier<CreditCardState> state = ValueNotifier(CreditCardEmptyState());
  CreditCardController() {
    init();
  }
  void init() async {
    state.value = CreditCardLoadState();
    await Future.delayed(const Duration(seconds: 1));
    final repository = Modular.get<CreditCardRepository>();

    List<CreditCardModel> list = await repository.loadList();
    if (list.isEmpty) {
      state.value = CreditCardEmptyState();
    } else {
      state.value = CreditCardSuccessState(list: list);
    }
  }

  Future<void> save(CreditCardModel creditCard) async {
    final repository = Modular.get<CreditCardRepository>();
    state.value = CreditCardLoadState();
    await repository.save(creditCard);
    List<CreditCardModel> list = await repository.loadList();
    await Future.delayed(const Duration(seconds: 1));
    state.value = CreditCardSuccessState(list: list);
  }

  void delete(String id) async {
    final repository = Modular.get<CreditCardRepository>();
    state.value = CreditCardLoadState();
    await repository.delete(id);
    List<CreditCardModel> list = await repository.loadList();
    state.value = CreditCardSuccessState(list: list);
  }

  Future<void> incrementCount(String creditCardId, double value) async {
    final repository = Modular.get<CreditCardRepository>();
    final creditCard = await repository.loadDoc(creditCardId);
    creditCard.spent += value;
    await save(creditCard);
  }

  Future<void> decrementCount(String creditCardId, double value) async {
    final repository = Modular.get<CreditCardRepository>();
    final creditCard = await repository.loadDoc(creditCardId);
    creditCard.spent -= value;
    await save(creditCard);
  }
}
