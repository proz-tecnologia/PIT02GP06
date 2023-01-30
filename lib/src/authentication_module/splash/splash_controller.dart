import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/authentication_module/auth_repository.dart';
import 'package:pit02gp06/src/authentication_module/splash/splash_state.dart';

class SplashController {
  ValueNotifier<SplashState> state = ValueNotifier(SplashStateInitial());
  SplashController() {
    init();
  }
  init() async {
    await Future.delayed(const Duration(seconds: 2));
    state.value = SplashStateLoading();
    await initFirebase();
    await Future.delayed(const Duration(seconds: 1));
    final user = await Modular.get<AuthRepository>().getUser();
    state.value = SplashStateAuthenticated(user: user);
  }

  Future<FirebaseApp> initFirebase() async {
    String apiKey = 'AIzaSyB0XDagU-SQzf1NXOJJUIoSpReFeuvDaXc';
    String appId = '1:166374888908:android:bd53ec09407a9775c17969';

    String messagingSenderId = '166374888908';
    String projectId = 'my-f-2ab0b';

    return await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
    ));
  }
}
