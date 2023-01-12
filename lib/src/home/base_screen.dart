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
