import 'package:flutter/material.dart';
import 'package:pit02gp06/src/home/home_page.dart';
import 'package:pit02gp06/src/page/details_screen.dart';
import 'package:pit02gp06/src/page/profile.screen.dart';
import 'package:pit02gp06/src/transactions/transactions_screen.dart';
import 'package:pit02gp06/src/widgets/bottom_navigation_bar.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<Widget> screens = [
//    HomeScreen(),
    HomePage(),
    TransactionsScreen(),
    const DetailsScreen(),
    const ProfileScreen()
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
