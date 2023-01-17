import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/authentication/splash/splash_controller.dart';
import 'package:pit02gp06/src/authentication/splash/splash_state.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = SplashController();
  @override
  void initState() {
    controller.state.addListener(() {
      if (controller.state.value.runtimeType == SplashStateAuthenticated) {
        Modular.to.pushReplacementNamed('/intro');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.backgroundColor,
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: height * 0.16,
                backgroundColor: AppColors.backgroundColor,
                child: Image.asset(
                  "lib/images/logo_my_f_transparente.png",
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (context, value, child) {
                  if (value.runtimeType == SplashStateInitial) {
                    return CircularProgressIndicator(
                      color: AppColors.grey1Color,
                    );
                  } else if (value.runtimeType == SplashStateLoading) {
                    return CircularProgressIndicator(
                        color: AppColors.blue1Color);
                  } else if (value.runtimeType == SplashStateAuthenticated) {
                    return Icon(
                      Icons.check,
                      color: AppColors.blue1Color,
                    );
                  } else if (value.runtimeType == SplashStateUnauthenticated) {
                    return Icon(Icons.not_interested,
                        color: AppColors.red1Color);
                  } else {
                    return Icon(Icons.error, color: AppColors.red1Color);
                  }
                },
              ),
              SizedBox(
                height: height * 0.20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
