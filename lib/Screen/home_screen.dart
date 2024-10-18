import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> itemMenu = [
  {
    'title': 'Categorías',
    'icon': Icons.account_tree_outlined,
    'iconColor': MyTheme.primary,
    'route': 'categories'
  },
  {
    'title': 'Proveedores',
    'icon': Icons.store_mall_directory,
    'iconColor': MyTheme.primary,
    'route': 'proveedores'
  },
  {
    'title': 'Productos',
    'icon': Icons.inventory_2_sharp,
    'iconColor': MyTheme.primary,
    'route': 'products'
  },
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: ListView.separated(
        itemCount: itemMenu.length,
        itemBuilder: (context, index) {
          return CardMenu(
            title: itemMenu[index]['title'],
            icon: itemMenu[index]['icon'],
            iconColor: itemMenu[index]['iconColor'],
            onTapDetail: () {
              Navigator.pushNamed(context, itemMenu[index]['route']);
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}
