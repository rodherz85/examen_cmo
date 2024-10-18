import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (_) => const LoginScreen(),
    'add_user': (_) => const RegisterUserScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'products': (BuildContext context) => const ProductsScreen(),
    'categories': (BuildContext context) => const CategoriesScreen(),
    'proveedores': (BuildContext context) => const ProveedoresScreen(),
    'edit_product': (BuildContext context) {
      final productService =
          Provider.of<ProductService>(context, listen: false);
      final product = productService.SelectProduct;
      if (product == null) {
        return const ErrorScreen();
      } else {
        return ChangeNotifierProvider(
          create: (_) => ProductFormProvider(product),
          child: ProductFormScreen(
            isUpdateMode: true,
            product: product,
          ),
        );
      }
    },
    'create_product': (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(ProductListModel(
            id: '', descripcion: '', nombre: '', precio: 0, stock: 0)),
        child: const ProductFormScreen(
          isUpdateMode: false,
        ),
      );
    },
    'detail_product': (BuildContext context) => const ProductDetailScreen(),
    'create_category': (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => CategoryFormProvider(
            CatListModel(id: '', nombre: '', codigo: '', estado: '')),
        child: const CategoryFormScreen(
          isUpdateMode: false,
        ),
      );
    },
    'edit_category': (BuildContext context) {
      final categoryService =
          Provider.of<CategoryService>(context, listen: false);
      final category = categoryService.SelectCategory;
      if (category == null) {
        return const ErrorScreen();
      } else {
        return ChangeNotifierProvider(
          create: (_) => CategoryFormProvider(category),
          child: CategoryFormScreen(
            isUpdateMode: true,
            category: category,
          ),
        );
      }
    },
    'detail_category': (BuildContext context) => const CategoryDetailScreen(),
    // Agrega la ruta para ProductDetailScreen
    'create_proveedor': (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => ProveedorFormProvider(ProvListModel(
            id: '', direccion: '', nombre: '', telefono: '', categoria: '')),
        child: const ProveedorFormScreen(
          isUpdateMode: false,
        ),
      );
    },
    'edit_proveedor': (BuildContext context) {
      final proveedorService =
          Provider.of<ProveedorService>(context, listen: false);
      final proveedor = proveedorService.SelectProveedor;
      if (proveedor == null) {
        return const ErrorScreen();
      } else {
        return ChangeNotifierProvider(
          create: (_) => ProveedorFormProvider(proveedor),
          child: ProveedorFormScreen(
            isUpdateMode: true,
            proveedor: proveedor,
          ),
        );
      }
    },
    'detail_proveedor': (BuildContext context) => const ProveedorDetailScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}
