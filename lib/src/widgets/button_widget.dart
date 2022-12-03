import 'package:flutter/material.dart';
import 'package:pit02gp06/src/page/base_screen.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  String text;
  Color color;
  ButtonWidget({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => BaseScreen())); // ROTA TESTE
          },
          child: Text(
            text,
            style: AppTextStyles.textButtonWidget, // Não funcionou
          ),
        ));
  }
}
