import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';

class TitleWidget extends StatelessWidget {
  String title;
  TitleWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
      child: Text(
        title,
        style: AppTextStyles.textTitle,
      ),
    );
  }
}
