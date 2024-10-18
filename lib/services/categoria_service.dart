import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryService extends ChangeNotifier {
  final String baseUrl =
      'firestore.googleapis.com'; //esta es la baseurl de la base de datos
  List<CatListModel> categories = [];
  CatListModel? SelectCategory;
  bool isLoading = true;

  CategoryService() {
    loadCategories();
  }

  Future<void> loadCategories() async {
    isLoading = true;
    notifyListeners();

    //  URL para la API de Firestore
    var url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/categorias'); //este es el endpoints para cargar/leer la base

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);

      final categoriesMap =
          ListadoCategorias.fromJson(jsonDecode(response.body));

      categories = categoriesMap.listadoCategorias;
    } else {
      throw Exception('Error al cargar las categorías: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String> updateCategory(CatListModel category) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/categorias/${category.id}'); //este es el endpoints para actualizar, aqui se rige por el ID único

    final Map<String, dynamic> data = {
      "fields": {
        "codigo": {"stringValue": category.codigo},
        "nombre": {"stringValue": category.nombre},
        "estado": {"stringValue": category.estado},
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

    final index = categories.indexWhere((element) => element.id == category.id);

    if (index != -1) {
      categories[index] = category;
      notifyListeners();
    }

    return '';
  }

  Future<String> createCategory(CatListModel category) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/categorias'); //Endpoint de la base de datos, tambien se usar para crear

    final Map<String, dynamic> data = {
      "fields": {
        "codigo": {"stringValue": category.codigo},
        "nombre": {"stringValue": category.nombre},
        "estado": {"stringValue": category.estado}
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

    if (response.statusCode == 201) {
      final newCategoryId = decodeResp['name']
          .split('/')
          .last; // Obtiene el ID del nuevo documento
      categories.add(category.copiarCategoria(
          id: newCategoryId)); // Agrega el producto a la lista
    }

    return '';
  }

  Future deleteCategory(CatListModel category, BuildContext context) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/categorias/${category.id}'); //Endpoint de la base de datos, para borrar por ID

    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;
    print(decodeResp);

    if (response.statusCode == 200) {
      categories.removeWhere((element) => element.id == category.id);
      notifyListeners();
    }

    return '';
  }
}
