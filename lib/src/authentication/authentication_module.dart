import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/authentication/splash/splash_screen.dart';

class AuthenticationModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashScreen()),
      ];
}
