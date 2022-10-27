import 'package:flutter/material.dart';

import '../common/colors.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({
    super.key,
    required this.balance,
    required this.income,
    required this.spend,
  });

  final String balance;
  final String income;
  final String spend;

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  int dropDownSelected = 1;
  bool secret = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Positioned(
            right: 1,
            child: _dropDown(),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              secret = !secret;
                            });
                          },
                          icon: Icon(
                            secret
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 25,
                            color: const Color(0xFF47525E),
                          )),
                      const SizedBox(height: 5),
                      Text(
                        "Saldo",
                        style: TextStyle(fontSize: 18, color: textColorDefault),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        secret ? '*****' : widget.balance,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: textColorDefault),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _financialMovementWidget(
                              "Receitas",
                              secret ? '*****' : widget.income,
                              const Color(0xFF1E38FA)),
                          _financialMovementWidget(
                              "Despesas",
                              secret ? '*****' : widget.spend,
                              const Color(0xFFDB353E)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _financialMovementWidget(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: textColorDefault),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 2,
                color: color,
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _dropDown() {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: DropdownButton(
        onChanged: (value) => setState(() {
          dropDownSelected = value ?? dropDownSelected;
        }),
        value: dropDownSelected,
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text("Janeiro"),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text("Fevereiro"),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text("Março"),
          ),
          DropdownMenuItem(
            value: 4,
            child: Text("Abril"),
          ),
          DropdownMenuItem(
            value: 5,
            child: Text("Maio"),
          ),
          DropdownMenuItem(
            value: 6,
            child: Text("Junho"),
          ),
          DropdownMenuItem(
            value: 7,
            child: Text("Julho"),
          ),
          DropdownMenuItem(
            value: 8,
            child: Text("Agosto"),
          ),
          DropdownMenuItem(
            value: 9,
            child: Text("Setembro"),
          ),
          DropdownMenuItem(
            value: 10,
            child: Text("Outubro"),
          ),
          DropdownMenuItem(
            value: 11,
            child: Text("Novembro"),
          ),
          DropdownMenuItem(
            value: 12,
            child: Text("Dezembro"),
          ),
        ],
      ),
    );
  }
}
