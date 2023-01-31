// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/src/home_module/profile/form_user_widget.dart';
import 'package:pit02gp06/src/home_module/profile/user_controller.dart';
import 'package:pit02gp06/src/home_module/profile/user_state.dart';
import 'package:pit02gp06/src/widgets/text_field_widget.dart';
import 'package:pit02gp06/utils/app_colors.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_loading_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = Modular.get<UserController>();

  @override
  Widget build(BuildContext context) {
    const String url = "https://cdn-icons-png.flaticon.com/512/847/847969.png";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(color: AppColors.grey1Color),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Builder(builder: ((context) {
            return IconButton(
                icon: const Icon(Icons.logout),
                color: AppColors.secondaryColor,
                onPressed: () {
                  logout();
                });
          }))
        ],
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(20, 20))),
        shadowColor: const Color.fromARGB(40, 0, 0, 0),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(52.0),
        child: Column(children: [
          ValueListenableBuilder(
            valueListenable: _controller.state,
            builder: (context, value, child) {
              if (value is UserLoadingState) {
                return Column(
                  children: [
                    const CustomCircularLoading(size: 114),
                    const SizedBox(height: 12),
                    CustomRectangularLoading(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.6,
                        radius: 10),
                    const SizedBox(height: 8),
                    CustomRectangularLoading(
                        height: 14,
                        width: MediaQuery.of(context).size.width * 0.9,
                        radius: 10),
                  ],
                );
              } else if (value is UserSuccessState) {
                final user = value.user;
                return Column(
                  children: [
                    // IMAGE

                    Container(
                      height: 114,
                      width: 114,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.fitWidth,
                          )),
                    ),
                    const SizedBox(height: 8), // NAME
                    Text(
                      user.name ?? '',
                      style: AppTextStyles.textNameProfileScreen,
                    ),
                    const SizedBox(height: 8),

                    // EMAIL

                    Text(
                      user.email ?? '',
                      style: AppTextStyles.textEmailProfileScreen,
                    ),
                    const SizedBox(height: 20),
                    // TEXT "MEUS DADOS"
                    FormUserWidget(
                      user: user,
                    ),
                  ],
                );
              } else {
                return const Text("Sem dados");
              }
            },
          ),
        ]),
      )),
    );
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }
}
