import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/home/home_controller.dart';
import 'package:pit02gp06/src/home/home_page.dart';
import 'package:pit02gp06/src/page/details_screen.dart';
import 'package:pit02gp06/src/page/profile.screen.dart';
import 'package:pit02gp06/src/transactions/transactions_screen.dart';
import 'package:pit02gp06/src/transactions/transactions_state.dart';
import 'package:pit02gp06/src/widgets/bottom_navigation_bar.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import '../transactions/transactions_controller.dart';
import 'package:firebase_core/firebase_core.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final transactionController = TransactionsController();
  final homeController = HomeController();
  final pageController = PageController();
  final categoryController = CategoryController();
  List<CategoryModel> categoryList = [];
  @override
  void initState() {
//todo: move initFirebase process to splash

    initFirebase();

//    categoryController.init();

    transactionController.state.addListener(() {
      if (transactionController.state.value is TransactionsSuccessState) {
        homeController.update(
            (transactionController.state.value as TransactionsSuccessState)
                .transactionsList);
      }
    });
    super.initState();
  }

  Future<void> initFirebase() async {
    String apiKey = 'AIzaSyB0XDagU-SQzf1NXOJJUIoSpReFeuvDaXc';
    String appId = '1:166374888908:android:bd53ec09407a9775c17969';

    String messagingSenderId = '166374888908';
    String projectId = 'my-f-2ab0b';

    var fireApp = await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
    ));
    log(fireApp.name);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomePage(
        controller: homeController,
      ),
      TransactionsScreen(
        transactionController: transactionController,
        categoryController: categoryController,
      ),
      const DetailsScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screens,
      ),
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: BottomNavBar(
        pageController: pageController,
        transactionsController: transactionController,
        categoryController: categoryController,
      ),
    );
  }
}
