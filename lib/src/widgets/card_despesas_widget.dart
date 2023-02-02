// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'central_pie_chart.dart';
import 'list_view_despesas_widget.dart';

class CardDespesasWidget extends StatelessWidget {
  final List<Map<String, Object>> data;
  const CardDespesasWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            SizedBox(
              height: 140,
              width: 140,
              child: CentralPieChart(
                data: data,
              ),
            ),
            SizedBox(
              height: 160,
              width: 250,
              child: ListViewDespesas(listCategorias: data),
            ),
          ],
        ),
      ),
    );
  }
}
