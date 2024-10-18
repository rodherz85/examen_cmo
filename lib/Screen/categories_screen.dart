import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if (categoryService.isLoading) return const LoadingScreen();

    final filteredCategories = categoryService.categories.where((category) {
      return category.nombre.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Listado de Categorías'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: MyTheme.secundary,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchField(
                  hintText: 'Buscar categorías...',
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                )),
          ),
        ),
        body: ListView.separated(
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            final category = filteredCategories[index];
            return ListTile(
              selectedColor: Colors.black,
              leading: const Icon(
                Icons.account_tree_outlined,
                color: MyTheme.primary,
                size: 30,
              ),
              title: Text(
                category.nombre.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Código: ${category.codigo.toUpperCase()}',
                style: const TextStyle(color: Colors.black),
              ),
              trailing: Text(
                'Estado: ${category.estado}',
                style: const TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'detail_category',
                    arguments: category);
              },
            );
          },
          separatorBuilder: (_, __) => const Divider(),
        ),
        floatingActionButton: FloatButton(onPressed: () {
          categoryService.SelectCategory = CatListModel(
            id: '',
            nombre: '',
            codigo: '',
            estado: '',
          ); // Reset SelectProduct
          Navigator.pushNamed(context, 'create_category');
        }));
  }
}
