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
              backgroundColor: AppColors.backgroundButtonBottomNavColor,
              child: Icon(Icons.add),
            ),
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add_business)),
                  Container(
                    width: size.width * 0.10,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.corporate_fare_rounded)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.account_circle_outlined)),
                ]),
          )
        ],
      ),
    );
  }
}
