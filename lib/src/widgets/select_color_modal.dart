import 'dart:developer';

import 'package:flutter/material.dart';

Future<dynamic> SelectColorModal(BuildContext context) async {
  List<int> colorList = [
    0xFF006C00,
    0xFF008401,
    0xFF00AE01,
    0xFF00E702,
    0xFF00F90B,
    0xFF00FD4C,
    0xFF6400FF,
    0xFF9600FF,
    0xFFC800FF,
    0xFFFA00FF,
    0xFFFA32FF,
    0xFFFA64FF,
    0xFF0000FF,
    0xC70032FF,
    0xC70064FF,
    0xC70096FF,
    0xC700C8FF,
    0xC500FAFF,
    0xC6FF0000,
    0xC6FF3200,
    0xC6FF6400,
    0xC6FF9600,
    0xC6FFC800,
    0xC6FFFA00,
  ];
  List<Widget> colorWidgetList = [];
  for (var e in colorList) {
    colorWidgetList.add(IconButton(
        onPressed: () {
//            color = e;
          Navigator.pop(context, e);
        },
        icon: Icon(
          Icons.color_lens,
          color: Color(e),
        )));
    log(e.toString());
  }
//  log(colorList.toString());
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Selecione uma cor",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 6,
                  children: colorWidgetList,
                )),
              ]),
        );
      });
}
