import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import 'central_pie_chart.dart';

class CardDespesasWidget extends StatelessWidget {
  const CardDespesasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final listaCustosPorCategoria = [
      {
        'genre': 'Lazer',
        'sold': 200,
        'color': Color.fromARGB(255, 85, 59, 255)
      },
      {
        'genre': 'Transporte',
        'sold': 130,
        'color': Color.fromARGB(255, 1, 161, 6)
      },
      {'genre': 'Casa', 'sold': 300, 'color': Color.fromARGB(255, 225, 15, 0)},
      {'genre': 'Outros', 'sold': 50, 'color': Color(0xFFF443B3)},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 190,
//              alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
//                crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CentralPieChart(data: listaCustosPorCategoria),
            Expanded(
              child: ListView.builder(
                  itemCount: listaCustosPorCategoria.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: listaCustosPorCategoria[index]['color']
                                  as Color,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listaCustosPorCategoria[index]['genre']
                                    .toString(),
                                style: AppTextStyles.textBalance,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "R\$ ${listaCustosPorCategoria[index]['sold'].toString()}",
                            style: AppTextStyles.textBalance,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
