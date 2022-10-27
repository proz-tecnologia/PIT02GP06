import 'package:flutter/material.dart';
import 'package:pit02gp06/src/page/details_screen.dart';
import 'package:pit02gp06/src/page/home_screen.dart';
import 'package:pit02gp06/src/page/profile.screen.dart';
import 'package:pit02gp06/src/page/transactions_screen.dart';
import 'package:pit02gp06/src/widgets/bottom_navigation_bar.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<Widget> screens = const [
    HomeScreen(),
    TransactionsScreen(),
    DetailsScreen(),
    ProfileScreen()
  ];

//  Widget currentScreen = HomeScreen();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screens,
      ),
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: BottomNavBar(
        pageController: pageController,
      ),
    );
  }
}
