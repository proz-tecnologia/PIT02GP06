import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';

// ignore: must_be_immutable
class ListViewDespesas extends StatefulWidget {
  List listCategorias;
  ListViewDespesas({super.key, required this.listCategorias});

  @override
  State<ListViewDespesas> createState() => _ListViewDespesasState();
}

class _ListViewDespesasState extends State<ListViewDespesas> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.listCategorias.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Color(widget.listCategorias[index]['color']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.listCategorias[index]['genre'].toString(),
                      style: AppTextStyles.textBalance,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  "R\$ ${widget.listCategorias[index]['sold'].toString()}",
                  style: AppTextStyles.textBalance,
                ),
              ),
            ],
          );
        });
  }
}
