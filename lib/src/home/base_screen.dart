import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:pit02gp06/src/home/home_controller.dart';
import 'package:pit02gp06/src/home/home_page.dart';
import 'package:pit02gp06/src/page/details_screen.dart';
import 'package:pit02gp06/src/page/profile.screen.dart';
import 'package:pit02gp06/src/transactions/transactions_screen.dart';
import 'package:pit02gp06/src/transactions/transactions_state.dart';
import 'package:pit02gp06/src/widgets/bottom_navigation_bar.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import '../transactions/transactions_controller.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final transactionController = TransactionsController();
  final homeController = Modular.get<HomeController>();
  final pageController = PageController();
  final categoryController = CategoryController();
  List<CategoryModel> categoryList = [];
  @override
  void initState() {
    transactionController.state.addListener(() {
      if (transactionController.state.value is TransactionsSuccessState) {
        homeUpdate();
      }
    });
    categoryController.state.addListener(() {
      if (categoryController.state.value is CategorySuccessState) {
        homeUpdate();
      }
    });
    super.initState();
  }

  void homeUpdate() {
    if (transactionController.state.value is TransactionsSuccessState &&
        categoryController.state.value is CategorySuccessState) {
      homeController.update(
          (transactionController.state.value as TransactionsSuccessState)
              .transactionsList,
          (categoryController.state.value as CategorySuccessState)
              .categoryList);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomePage(),
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
