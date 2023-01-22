import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/authentication_module/authentication_module.dart';
import 'package:pit02gp06/src/home_module/home_module.dart';
import 'package:pit02gp06/src/page/intro/intro_screen_controller.dart';

import 'authentication_module/auth_repository.dart';
import 'page/login/login_screen_controller.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind.factory((i) => AuthRepository())];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: AuthenticationModule()),
        ChildRoute('/intro', child: (_, args) => const IntroScreenController()),
        ChildRoute('/login', child: (_, args) => const LoginScreenController()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
