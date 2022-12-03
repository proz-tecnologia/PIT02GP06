import 'package:flutter/material.dart';
import 'package:pit02gp06/src/widgets/list_view_despesas_widget.dart';

import 'central_pie_chart.dart';

class CardDespesasWidget extends StatelessWidget {
  const CardDespesasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final listaCustosPorCategoria = [
    //   {'genre': 'Lazer', 'sold': 200, 'color': Color(0xFF5A41FF)},
    //   {'genre': 'Transporte', 'sold': 130, 'color': Color(0xFF0F0297)},
    //   {'genre': 'Casa', 'sold': 300, 'color': Color(0xFFE10F00)},
    //   {'genre': 'Outros', 'sold': 50, 'color': Color(0xFFE6F201)},
    // ];
    final listaCustosPorCategoria = [
      {'genre': 'Lazer', 'sold': 200, 'color': 0xFF5A41FF},
      {'genre': 'Transporte', 'sold': 130, 'color': 0xFF0F0297},
      {'genre': 'Casa', 'sold': 300, 'color': 0xFFE10F00},
      {'genre': 'Outros', 'sold': 50, 'color': 0xFFE6F201},
    ];

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: CentralPieChart(data: listaCustosPorCategoria),
            ),
            const SizedBox(
              height: 150,
              width: 16,
            ),
            Expanded(
              child: SizedBox(
                height: 150,
                child:
                    ListViewDespesas(listCategorias: listaCustosPorCategoria),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
