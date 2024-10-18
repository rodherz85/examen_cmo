import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String baseUrl =
      'firestore.googleapis.com'; //esta es la baseurl de la base de datos
  List<ProductListModel> products = [];
  ProductListModel? SelectProduct;
  bool isLoading = true;

  ProductService() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    //  URL para la API de Firestore
    var url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/productos'); //este es el endpoints para cargar/leer la base

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);

      final productsMap = ListadoProductos.fromJson(jsonDecode(response.body));

      products = productsMap.listadoProductos;
    } else {
      throw Exception('No carga la lista de productos: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String> updateProduct(ProductListModel product) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/productos/${product.id}'); //este es el endpoints para actualizar, aqui se rige por el ID único

    final Map<String, dynamic> data = {
      "fields": {
        "descripcion": {"stringValue": product.descripcion},
        "nombre": {"stringValue": product.nombre},
        "precio": {"integerValue": product.precio.toString()},
        "stock": {"integerValue": product.stock.toString()},
      },
    };
    final response = await http.patch(
      url,
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final decodeResp = response.body;
    print(decodeResp);

    final index = products.indexWhere((element) => element.id == product.id);

    if (index != -1) {
      products[index] = product;
      notifyListeners();
    }
    return '';
  }

  Future<String> createProduct(ProductListModel product) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/productos'); //Endpoint de la base de datos, tambien se usar para crear

    final Map<String, dynamic> data = {
      "fields": {
        "descripcion": {"stringValue": product.descripcion},
        "nombre": {"stringValue": product.nombre},
        "precio": {"integerValue": product.precio.toString()},
        "stock": {"integerValue": product.stock.toString()},
      },
    };

    final response = await http.post(
      url,
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final decodeResp = json.decode(response.body);
    print(decodeResp);

    final newProductId =
        decodeResp['name'].split('/').last; // Obtiene el ID del nuevo documento
    products.add(product.copiarProducto(
        id: newProductId)); // Agrega el producto a la lista

    return '';
  }

  Future deleteProduct(ProductListModel product, BuildContext context) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/productos/${product.id}'); //Endpoint de la base de datos, para borrar por ID

    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;
    print(decodeResp);

    if (response.statusCode == 200) {
      products.removeWhere((element) => element.id == product.id);
      notifyListeners();
    }
  }
}
