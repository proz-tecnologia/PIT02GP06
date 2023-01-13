import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/authentication/authentication_module.dart';
import 'package:pit02gp06/src/home/home_module.dart';

import 'authentication/auth_repository.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind.factory((i) => AuthRepository())];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: AuthenticationModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
