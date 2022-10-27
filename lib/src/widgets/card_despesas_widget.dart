import 'package:flutter/material.dart';
import 'package:pit02gp06/src/widgets/list_view_despesas_widget.dart';

import 'central_pie_chart.dart';

class CardDespesasWidget extends StatelessWidget {
  const CardDespesasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final listaCustosPorCategoria = [
      {
        'genre': 'Lazer',
        'sold': 200,
        'color': const Color.fromARGB(255, 90, 65, 255)
      },
      {
        'genre': 'Transporte',
        'sold': 130,
        'color': const Color.fromARGB(255, 15, 2, 151)
      },
      {
        'genre': 'Casa',
        'sold': 300,
        'color': const Color.fromARGB(255, 225, 15, 0)
      },
      {
        'genre': 'Outros',
        'sold': 50,
        'color': const Color.fromARGB(255, 230, 242, 1)
      },
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
