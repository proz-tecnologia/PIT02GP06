import 'package:flutter/material.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  PageController pageController;
  BottomNavBar({super.key, required this.pageController});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  int index = 0;
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    void changeIndex(value) {
      setState(() {
        widget.pageController.jumpToPage(value);
        index = value;
      });
    }

    return Container(
      width: size.width,
      height: 70,
      color: AppColors.backgroundCardColor,
      child: Stack(
        children: [
          CustomPaint(size: Size(size.width, 80)),
          Center(
            heightFactor: 0.5,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColors.textValueIncome,
              child: const Icon(Icons.add),
            ),
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      changeIndex(0);
                    },
                    icon: const Icon(Icons.home),
                    color: index == 0
                        ? AppColors.textValueIncome
                        : AppColors.textTitleColor,
                    tooltip: 'Principal',
                    // isSelected: ,
                  ),
                  IconButton(
                    onPressed: () {
                      changeIndex(1);
                    },
                    icon: const Icon(Icons.change_circle),
                    color: index == 1
                        ? AppColors.textValueIncome
                        : AppColors.textTitleColor,
                    tooltip: 'Transações',
                  ),
                  Container(
                    width: size.width * 0.10,
                  ),
                  IconButton(
                    onPressed: () {
                      changeIndex(2);
                    },
                    icon: const Icon(Icons.list),
                    color: index == 2
                        ? AppColors.textValueIncome
                        : AppColors.textTitleColor,
                    tooltip: 'Detalhes',
                  ),
                  IconButton(
                    onPressed: () {
                      changeIndex(3);
                    },
                    icon: const Icon(Icons.person_outline),
                    color: index == 3
                        ? AppColors.textValueIncome
                        : AppColors.textTitleColor,
                    tooltip: 'Perfil',
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
