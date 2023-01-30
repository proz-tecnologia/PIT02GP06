import 'package:firebase_auth/firebase_auth.dart';
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
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    final nameItem = TextFieldItem(
      label: 'Nome Completo',
    );
    final phoneItem = TextFieldItem(label: 'Telefone');
    const String url = "https://cdn-icons-png.flaticon.com/512/847/847969.png";
    final dropValue = ValueNotifier('');
    final dropOptions = ['Feminino', 'Masculino', 'Não informado'];

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(52.0),
        child: Column(children: [
          // IMAGE
          Container(
            height: 115,
            width: 115,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fitWidth,
                )),
          ),
          // NAME
          Text(
            'Nome Exemplo',
            style: AppTextStyles.textNameProfileScreen,
          ),
          // EMAIL
          Text(
            'email@exemplo.com.br',
            style: AppTextStyles.textEmailProfileScreen,
          ),
          const SizedBox(height: 20),
          // TEXT "MEUS DADOS"
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Meus dados',
              style: AppTextStyles.textButtonSecondaryBlue,
            ),
          ),
          Divider(
            color: AppColors.secondaryColor,
            thickness: 0.5,
          ),
          const SizedBox(height: 10),
          // INPUT FULL NAME
          TextFieldWidget(
            item: nameItem,
            borderColor: AppColors.grey2Color,
          ),
          // DATE
          Container(
            height: 58,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.grey2Color),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _dateTime == null
                        ? 'Data de Nascimento'
                        : _dateTime.toString(),
                    style: AppTextStyles.textFieldProfileScreen,
                  ),
                  IconButton(
                      color: AppColors.grey3Color,
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // PHONE
          TextFieldWidget(
            item: phoneItem,
            borderColor: AppColors.grey2Color,
          ),
          // GENDER
          ValueListenableBuilder(
              valueListenable: dropValue,
              builder: (BuildContext context, String value, _) {
                return SizedBox(
                  width: 290,
                  height: 58,
                  child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      hint: const Text('Gênero'),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (choice) =>
                          dropValue.value = choice.toString(),
                      items: dropOptions
                          .map((op) => DropdownMenuItem(
                                value: op,
                                child: Text(
                                  op,
                                  style: AppTextStyles.textFieldProfileScreen,
                                ),
                              ))
                          .toList()),
                );
              }),
          const SizedBox(height: 10),
          // BUTTON "SALVAR"
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(290, 50),
                padding: const EdgeInsets.all(18),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
            child: Text(
              "Salvar",
              style: AppTextStyles.textButtonWidget,
            ),
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
