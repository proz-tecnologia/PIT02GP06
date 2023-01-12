import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class FormCategoryPage extends StatefulWidget {
  final CategoryModel? category;
  final String type;
  const FormCategoryPage({required this.type, super.key, this.category});

  @override
  State<FormCategoryPage> createState() => _FormCategoryPageState();
}

class _FormCategoryPageState extends State<FormCategoryPage> {
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool replaceDefault = true;
  @override
  Widget build(BuildContext context) {
    if (widget.category != null && replaceDefault) {
      textController.text = widget.category!.genre;
      replaceDefault = false;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00127A),
        title: widget.category == null
            ? const Text("Adicionar Categoria")
            : const Text("Editar Categoria"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                controller: textController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'preencha com um nome que contenha no mínimo 3 caracteres';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Valor (Ex. Viagem)'),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  onPressed: _formKey.currentState?.validate() == true
                      ? () {
                          final category = CategoryModel(
                              genre: textController.text,
                              color: widget.category != null
                                  ? widget.category!.color
                                  : 0xFF0F0297,
                              type: widget.type);
                          Navigator.pop(context, category);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00127A),
                    fixedSize: Size(MediaQuery.of(context).size.width / 2, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Salvar"),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.save),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
