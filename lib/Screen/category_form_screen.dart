import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryFormScreen extends StatelessWidget {
  final bool isUpdateMode;
  final CatListModel? category;

  const CategoryFormScreen(
      {super.key, required this.isUpdateMode, this.category});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    final categoryFormProvider = Provider.of<CategoryFormProvider>(context);

    if (category != null) {
      categoryFormProvider.category = category!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear/Editar Categoría'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: categoryFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFieldWidget(
                label: 'Nombre',
                initialValue: categoryFormProvider.category.nombre,
                onChanged: (value) => categoryFormProvider.category =
                    categoryFormProvider.category
                        .copiarCategoria(nombre: value),
              ),
              TextFieldWidget(
                label: 'Código',
                initialValue: categoryFormProvider.category.codigo,
                onChanged: (value) => categoryFormProvider.category =
                    categoryFormProvider.category
                        .copiarCategoria(codigo: value),
              ),
              TextFieldWidget(
                label: 'Estado',
                initialValue: categoryFormProvider.category.estado,
                onChanged: (value) => categoryFormProvider.category =
                    categoryFormProvider.category
                        .copiarCategoria(estado: value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!categoryFormProvider.isValidForm()) return;
                  if (isUpdateMode) {
                    await categoryService
                        .updateCategory(categoryFormProvider.category);
                  } else {
                    await categoryService
                        .createCategory(categoryFormProvider.category);
                  }
                  await categoryService.loadCategories();
                  MensajeWidget.showSnackBar(
                      context, 'Categpría agregada exitosamente');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'categories', (Route<dynamic> route) => false);
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(MyTheme.primary),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
