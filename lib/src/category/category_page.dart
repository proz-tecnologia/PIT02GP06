import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pit02gp06/models/category_model.dart';
import 'package:pit02gp06/src/category/category_bloc.dart';
import 'package:pit02gp06/src/category/category_events.dart';
import 'package:pit02gp06/src/category/category_states.dart';
import 'package:pit02gp06/src/widgets/select_color_modal.dart';

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
                    trailing: IconButton(
                      icon: Icon(Icons.color_lens),
                      onPressed: () async {
                        var color;
                        color = await SelectColorModal(context);
                        log("color retornada $color");
                        categoryList[index].color = color;
                      },
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
