import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pit02gp06/src/widgets/custom_loading_widget.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../home_module/profile/user_controller.dart';
import '../home_module/profile/user_state.dart';

// ignore: must_be_immutable
class HeaderUserCard extends StatefulWidget {
  const HeaderUserCard({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderUserCard> createState() => _HeaderUserCardState();
}

class _HeaderUserCardState extends State<HeaderUserCard> {
  final controller = Modular.get<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.elliptical(30, 30))),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
        child: ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (context, value, child) {
            if (value is UserSuccessState) {
              final user = value.user;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.whiteColor,
                        foregroundColor: AppColors.grey2Color,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Olá,",
                            style: AppTextStyles.textHello,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.name!,
                            style: AppTextStyles.textName,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.notifications,
                    size: 30,
                    color: AppColors.grey2Color,
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomCircularLoading(size: 50),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Olá,",
                            style: AppTextStyles.textHello,
                          ),
                          const SizedBox(height: 4),
                          const CustomRectangularLoading(
                              height: 26, width: 120, radius: 6),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.notifications,
                    size: 30,
                    color: AppColors.grey2Color,
                  ),
                ],
              );
            }
          },
        ),
      )),
    );
  }
}
