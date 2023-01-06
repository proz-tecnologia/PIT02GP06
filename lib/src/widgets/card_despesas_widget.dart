import 'package:flutter/material.dart';

import 'central_pie_chart.dart';
import 'list_view_despesas_widget.dart';

class CardDespesasWidget extends StatelessWidget {
  const CardDespesasWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              height: 140,
              width: 140,
              child: CentralPieChart(data: [
                {'genre': 'Lazer', 'sold': 200, 'color': 0xFF5A41FF},
                {'genre': 'Transporte', 'sold': 130, 'color': 0xFF0F0297},
                {'genre': 'Casa', 'sold': 300, 'color': 0xFFE10F00},
                {'genre': 'Outros', 'sold': 50, 'color': 0xFFE6F201},
              ]),
            ),
            Container(
              height: 160,
              width: 200,
              child: ListViewDespesas(listCategorias: [
                {'genre': 'Lazer', 'sold': 200, 'color': 0xFF5A41FF},
                {'genre': 'Transporteeeeee', 'sold': 130, 'color': 0xFF0F0297},
                {'genre': 'Casa', 'sold': 300, 'color': 0xFFE10F00},
                {'genre': 'Outros', 'sold': 50, 'color': 0xFFE6F201},
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
