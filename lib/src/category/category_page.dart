import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/src/category/category_bloc.dart';
import 'package:pit02gp06/src/category/category_events.dart';
import 'package:pit02gp06/src/category/category_states.dart';
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
    // TODO: implement initState
    super.initState();
    bloc = CategoryBloc();
    bloc.inputCategory.add(LoadCategoryEvent());
  }

  @override
  void dispose() {
    bloc.inputCategory.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Categorias"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .push<CategoryModel?>(MaterialPageRoute(
                        builder: (context) => FormCategoryPage()))
                    .then((value) {
                  if (value != null && value.runtimeType == CategoryModel) {
                    bloc.inputCategory.add(AddCategoryEvent(category: value));
                  }
                });
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder<CategoryState>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              final categoryList = snapshot.data?.categoryList ?? [];
              return ListView.builder(
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(categoryList[index].color),
                      child: ClipRRect(
                        child: Text(categoryList[index].genre.substring(0, 1)),
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
                              if (color != null && color.runtimeType == int) {
                                categoryList[index].color = color;
                                bloc.inputCategory.add(EditCategoryEvent(
                                    index: index,
                                    category: categoryList[index]));
                              }
                            },
                          ),
                          IconButton(
                            onPressed: () async {
                              await Navigator.of(context)
                                  .push<CategoryModel?>(MaterialPageRoute(
                                      builder: (context) => FormCategoryPage(
                                          category: categoryList[index])))
                                  .then((value) {
                                if (value != null &&
                                    value.runtimeType == CategoryModel) {
                                  bloc.inputCategory.add(EditCategoryEvent(
                                      index: index, category: value));
                                }
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              if (index < 2) {
                                const snackBar = SnackBar(
                                  content:
                                      Text('Este ítem não pode ser excluído!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                return;
                              }
                              bloc.inputCategory.add(RemoveCategoryEvent(
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
    );
  }
}
