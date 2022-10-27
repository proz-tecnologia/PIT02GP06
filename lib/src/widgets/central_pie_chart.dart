import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class CentralPieChart extends StatefulWidget {
  final List<Map<String, Object>> data;

//exemplo de entrada
  // final listaCustosPorCategoria = [
  //   {'genre': 'Lazer', 'sold': 200, 'color': Color.fromARGB(255, 85, 59, 255)},
  //   {'genre': 'Transporte', 'sold': 500, 'color': Color.fromARGB(255, 1, 161, 6)},
  //   {'genre': 'Mercado', 'sold': 100, 'color': Color.fromARGB(255, 240, 228, 1)},
  //   {'genre': 'Casa', 'sold': 800, 'color': Color.fromARGB(255, 225, 15, 0)},
  //   {'genre': 'Outros', 'sold': 100, 'color': Color(0xFFF443B3)},
  // ];

  const CentralPieChart({super.key, required this.data});

  @override
  State<CentralPieChart> createState() => _CentralPieChartState(data: data);
}

class _CentralPieChartState extends State<CentralPieChart> {
  final data;

  List<Color> cores = [];
  _CentralPieChartState({this.data}) {
    cores = List.from(data.map((e) => e['color']));
    log(cores.toString());
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Chart(
        data: data,
        variables: {
          'genre': Variable(
            accessor: (Map map) => map['genre'] as String,
          ),
          'sold': Variable(
            accessor: (Map map) => map['sold'] as num,
          ),
        },
        transforms: [
          Proportion(
            variable: 'sold',
            as: 'percent',
          )
        ],
        elements: [
          IntervalElement(
            position: Varset('percent') / Varset('genre'),
            color: ColorAttr(variable: 'genre', values: cores),
            modifiers: [StackModifier()],
          )
        ],
        coord: PolarCoord(
          transposed: true,
          dimCount: 1,
          startRadius: 0.5,
        ),
      ),
    );
  }
}
