import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PruebaProviders extends ChangeNotifier {
  final String baseUrl =
      'firestore.googleapis.com'; //esta es la baseurl de la base de datos

  PruebaProviders() {
    loadProducts();
  }

  loadProducts() async {
    //  URL para la API de Firestore
    var url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/proveedores'); //este es el endpoints para cargar/leer la base

    final response = await http.get(url);
    print(response.body);
    notifyListeners();
  }
}
