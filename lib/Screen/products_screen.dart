import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();

    final filteredProducts = productService.products.where((product) {
      return product.nombre.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Productos'),
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
                hintText: 'Buscar productos...',
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
              )),
        ),
      ),
      body: ListView.separated(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return ListTile(
            selectedColor: Colors.black,
            leading: const Icon(
              Icons.inventory,
              color: MyTheme.primary,
              size: 30,
            ),
            title: Text(
              product.nombre.toUpperCase(),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${product.descripcion.toUpperCase()} - \$${product.precio}',
              style: const TextStyle(color: Colors.black),
            ),
            trailing: Text(
              'Stock: ${product.stock}',
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'detail_product',
                  arguments: product);
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
      floatingActionButton: FloatButton(
        onPressed: () {
          productService.SelectProduct = ProductListModel(
              id: '', descripcion: '', nombre: '', precio: 0, stock: 0);
          Navigator.pushNamed(context, 'create_product');
        },
      ),
    );
  }
}
