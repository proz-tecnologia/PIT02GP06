import 'package:flutter/material.dart';
import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/src/widgets/text_field_widget.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime? _dateTime = null;

  @override
  Widget build(BuildContext context) {
    final nameItem = TextFieldItem(
      label: 'Nome Completo',
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: AppColors.secondaryColor,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(52.0),
        child: Column(children: [
          Text(
            'Meus dados',
            style: AppTextStyles.textButtonSecondaryBlue,
          ),
          TextFieldWidget(
            item: nameItem,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                IconButton(
                    iconSize: 30,
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2222))
                          .then((date) {
                        setState(() {
                          _dateTime = date!;
                        });
                      });
                    },
                    icon: const Icon(Icons.calendar_month)),
                Text(_dateTime == null
                    ? 'Data de Nascimento'
                    : _dateTime.toString()),
              ],
            ),
          )
        ]),
      )),
    );
  }
}
