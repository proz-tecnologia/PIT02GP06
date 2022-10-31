import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';

// ignore: must_be_immutable
class TitleWidget extends StatelessWidget {
  String title;
  TitleWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 2),
      child: Text(
        title,
        style: AppTextStyles.textTitle,
      ),
    );
  }
}
