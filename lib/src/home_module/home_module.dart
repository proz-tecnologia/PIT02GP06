import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/repositories/credit_card_repository.dart';
import 'package:pit02gp06/repositories/transactions_repository.dart';
import 'package:pit02gp06/src/home_module/category/category_controller.dart';
import 'package:pit02gp06/src/home_module/base_screen.dart';
import 'package:pit02gp06/src/home_module/credit_card/credit_card_controller.dart';
import 'package:pit02gp06/src/home_module/home/home_controller.dart';
import 'package:pit02gp06/src/home_module/transactions/transactions_controller.dart';
import 'credit_card/credit_card_register_screen.dart';

import 'profile/user_controller.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => TransactionsRepository()),
        Bind.factory((i) => CreditCardRepository()),
        Bind.singleton((i) => HomeController()),
        Bind.singleton((i) => CategoryController()),
        Bind.singleton((i) => TransactionsController()),
        Bind.singleton((i) => CreditCardController()),
        Bind.lazySingleton((i) => UserController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const BaseScreen(),
        ),
        ChildRoute('/credit_card_register',
            child: (_, args) => CreditCardRegisterScreen(
                  viewModel: args.data['viewModel'],
                  onRegister: args.data['onRegister'],
                )),
      ];
}
