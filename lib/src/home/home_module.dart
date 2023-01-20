import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/repositories/transactions_repository.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/home/base_screen.dart';
import 'package:pit02gp06/src/home/home_controller.dart';
import 'package:pit02gp06/src/page/credit_card_register_screen.dart';
import 'package:pit02gp06/src/transactions/transactions_controller.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => TransactionsRepository()),
        Bind.singleton((i) => HomeController()),
        Bind.singleton((i) => CategoryController()),
        Bind.singleton((i) => TransactionsController()),
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
