import 'package:flutter/material.dart';
import 'package:pit02gp06/utils/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int index = 0;

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
                    onPressed: () {},
                    icon: const Icon(Icons.home),
                    color: AppColors.textValueIncome,
                    tooltip: 'Principal',
                    // isSelected: ,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_business),
                    color: AppColors.textTitleColor,
                    tooltip: 'Transações',
                  ),
                  Container(
                    width: size.width * 0.10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.list),
                    color: AppColors.textTitleColor,
                    tooltip: 'Detalhes',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_outline),
                    color: AppColors.textTitleColor,
                    tooltip: 'Perfil',
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
