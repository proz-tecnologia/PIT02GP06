import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/src/category/category_controller.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:pit02gp06/src/widgets/custom_app_bar.dart';
import 'package:pit02gp06/src/widgets/select_color_modal.dart';
import 'package:pit02gp06/utils/app_colors.dart';

import 'form_category_page.dart';

class CategoryPage extends StatefulWidget {
  final CategoryController controller;
  final String? type;
  const CategoryPage(
      {super.key, required this.controller, this.type = "Income"});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
//  final List<CategoryModel> categoryList = [];
//  late final CategoryController controller;
  Object dropDownTypeValue = 0;

  @override
  void initState() {
    if (widget.type == "Expense") dropDownTypeValue = 1;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> listType = ['Income', 'Expense'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            title: "Categorias",
            actions: [
              IconButton(
                  onPressed: () async {
                    await Navigator.of(context)
                        .push<CategoryModel?>(MaterialPageRoute(
                            builder: (context) => FormCategoryPage(
                                type: listType[
                                    int.parse(dropDownTypeValue.toString())])))
                        .then((value) {
                      if (value != null && value.runtimeType == CategoryModel) {
                        widget.controller.add(value);
                      }
                    });
                  },
                  icon: const Icon(Icons.add)),
            ],
          ),
          SizedBox(
            width: 100,
            child: DropdownButton(
                value: dropDownTypeValue,
                items: const [
                  DropdownMenuItem(value: 0, child: Text("Receitas")),
                  DropdownMenuItem(value: 1, child: Text("Despesas")),
                ],
                onChanged: (value) {
                  setState(() {
                    dropDownTypeValue = value!;
                  });
                }),
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: widget.controller.state,
                builder: (context, value, child) {
                  final categoryList = value.runtimeType == CategorySuccessState
                      ? (value as CategorySuccessState).categoryList
                      : [];
                  return ListView.builder(
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return listType[
                                  int.parse(dropDownTypeValue.toString())] !=
                              categoryList[index].type
                          ? const SizedBox()
                          : ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Color(categoryList[index].color),
                                child: ClipRRect(
                                  child: Text(categoryList[index]
                                      .genre
                                      .substring(0, 1)),
                                ),
                              ),
                              title: Text(categoryList[index].genre),
                              trailing: SizedBox(
                                width: 150,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.color_lens,
                                        color: Color(categoryList[index].color),
                                      ),
                                      onPressed: () async {
                                        int color =
                                            await SelectColorModal(context);
                                        log("color retornada $color");
                                        if (color.runtimeType == int) {
                                          categoryList[index].color = color;
                                          widget.controller
                                              .edit(index, categoryList[index]);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await Navigator.of(context)
                                            .push<CategoryModel?>(MaterialPageRoute(
                                                builder: (context) =>
                                                    FormCategoryPage(
                                                        type: listType[int.parse(
                                                            dropDownTypeValue
                                                                .toString())],
                                                        category: categoryList[
                                                            index])))
                                            .then((value) {
                                          if (value != null &&
                                              value.runtimeType ==
                                                  CategoryModel) {
                                            widget.controller
                                                .edit(index, value);
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (index < 2) {
                                          const snackBar = SnackBar(
                                            content: Text(
                                                'Este ítem não pode ser excluído!'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          return;
                                        }
                                        widget.controller.delete(index);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
