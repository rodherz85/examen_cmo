import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatelessWidget {
  final bool isUpdateMode;
  final ProductListModel? product;

  const ProductFormScreen(
      {super.key, required this.isUpdateMode, this.product});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final productFormProvider = Provider.of<ProductFormProvider>(context);

    if (product != null) {
      productFormProvider.product = product!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear/Editar Producto'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: productFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFieldWidget(
                label: 'Nombre',
                initialValue: productFormProvider.product.nombre,
                onChanged: (value) => productFormProvider.product =
                    productFormProvider.product.copiarProducto(nombre: value),
              ),
              TextFieldWidget(
                label: 'Descripción',
                initialValue: productFormProvider.product.descripcion,
                onChanged: (value) => productFormProvider.product =
                    productFormProvider.product
                        .copiarProducto(descripcion: value),
              ),
              TextFieldWidget(
                label: 'Precio',
                initialValue: productFormProvider.product.precio.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) => productFormProvider.product =
                    productFormProvider.product.copiarProducto(
                  precio: value.isEmpty ? 0 : int.parse(value),
                ),
              ),
              TextFieldWidget(
                label: 'Stock',
                initialValue: productFormProvider.product.stock.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) => productFormProvider.product =
                    productFormProvider.product.copiarProducto(
                  stock: value.isEmpty ? 0 : int.parse(value),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!productFormProvider.isValidForm()) return;
                  if (isUpdateMode) {
                    await productService
                        .updateProduct(productFormProvider.product);
                  } else {
                    await productService
                        .createProduct(productFormProvider.product);
                  }
                  await productService.loadProducts();
                  MensajeWidget.showSnackBar(
                      context, 'Producto agregado exitosamente');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'products', (Route<dynamic> route) => false);
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
