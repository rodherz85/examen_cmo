import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as CatListModel;
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la Categoría'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              await categoryService.deleteCategory(category, context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'categories', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${category.nombre}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 10),
            Text('Codigo: ${category.codigo}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 10),
            Text('Estado: ${category.estado}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  categoryService.SelectCategory = category;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => CategoryFormProvider(category),
                        child: CategoryFormScreen(
                          isUpdateMode: true,
                          category: category,
                        ),
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(MyTheme.primary),
                ),
                child: const Text(
                  'Editar Categoría',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
