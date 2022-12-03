import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/src/category/category_bloc.dart';
import 'package:pit02gp06/src/category/category_events.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:pit02gp06/src/widgets/custom_app_bar.dart';
import 'package:pit02gp06/src/widgets/select_color_modal.dart';
import 'package:pit02gp06/utils/app_colors.dart';

import 'form_category_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
//  final List<CategoryModel> categoryList = [];
  late final CategoryBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = CategoryBloc();
    bloc.inputCategory.add(LoadCategoryEvent());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.inputCategory.close();
  }

  Object dropDownTypeValue = 0;
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
                        bloc.inputCategory
                            .add(AddCategoryEvent(category: value));
                      }
                    });
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
          SizedBox(
            width: 100,
            child: DropdownButton(
                value: dropDownTypeValue,
                items: [
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
            child: StreamBuilder<CategoryState>(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final categoryList = snapshot.data?.categoryList ?? [];
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
                                        var color;
                                        color = await SelectColorModal(context);
                                        log("color retornada $color");
                                        if (color != null &&
                                            color.runtimeType == int) {
                                          categoryList[index].color = color;
                                          bloc.inputCategory.add(
                                              EditCategoryEvent(
                                                  index: index,
                                                  category:
                                                      categoryList[index]));
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
                                            bloc.inputCategory.add(
                                                EditCategoryEvent(
                                                    index: index,
                                                    category: value));
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
                                        bloc.inputCategory.add(
                                            RemoveCategoryEvent(
                                                category: categoryList[index]));
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
