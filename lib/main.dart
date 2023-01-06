// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:pit02gp06/src/page/base_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Grupo 6',
//       localizationsDelegates: const [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate
//       ],
//       supportedLocales: const [Locale('pt', 'BR')],
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const BaseScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/AppModule.dart';
import 'package:pit02gp06/src/app_widget.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
