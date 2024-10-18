import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments as ProductListModel;
    final productService = Provider.of<ProductService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              await productService.deleteProduct(product, context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'products', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${product.nombre}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 10),
            Text('Descripción: ${product.descripcion}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 10),
            Text('Precio: \$${product.precio}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 10),
            Text('Stock: ${product.stock}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  productService.SelectProduct = product;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => ProductFormProvider(product),
                        child: ProductFormScreen(
                          isUpdateMode: true,
                          product: product,
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
                  'Editar Producto',
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
