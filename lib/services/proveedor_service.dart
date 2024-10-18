import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProveedorService extends ChangeNotifier {
  final String baseUrl =
      'firestore.googleapis.com'; //esta es la baseurl de la base de datos
  List<ProvListModel> proveedores = [];
  ProvListModel? SelectProveedor;
  bool isLoading = true;

  ProveedorService() {
    loadProveedores();
  }

  Future<void> loadProveedores() async {
    isLoading = true;
    notifyListeners();

    //  URL para la API de Firestore
    var url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/proveedores'); //este es el endpoints para cargar/leer la base

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);

      final proveedoresMap =
          ListadoProveedores.fromJson(jsonDecode(response.body));

      proveedores = proveedoresMap.listadoProveedores;
    } else {
      throw Exception(
          'Error al cargar los proveedores: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String> updateProveedor(ProvListModel proveedor) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/proveedores/${proveedor.id}'); //este es el endpoints para actualizar, aqui se rige por el ID único

    final Map<String, dynamic> data = {
      "fields": {
        "categoria": {"stringValue": proveedor.categoria},
        "nombre": {"stringValue": proveedor.nombre},
        "telefono": {"stringValue": proveedor.telefono},
        "direccion": {"stringValue": proveedor.direccion},
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

    final index =
        proveedores.indexWhere((element) => element.id == proveedor.id);

    if (index != -1) {
      proveedores[index] = proveedor;
    }

    return '';
  }

  Future<String> createProveedor(ProvListModel proveedor) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/proveedores'); //Endpoint de la base de datos, tambien se usar para crear

    final Map<String, dynamic> data = {
      "fields": {
        "categoria": {"stringValue": proveedor.categoria},
        "nombre": {"stringValue": proveedor.nombre},
        "telefono": {"stringValue": proveedor.telefono},
        "direccion": {"stringValue": proveedor.direccion}
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
      final newProveedorId = decodeResp['name']
          .split('/')
          .last; // Obtiene el ID del nuevo documento
      proveedores.add(proveedor.copiarProveedor(
          id: newProveedorId)); // Agrega el producto a la lista
    }

    return '';
  }

  Future deleteProveedor(ProvListModel proveedor, BuildContext context) async {
    final url = Uri.https(baseUrl,
        '/v1/projects/prueba3-movil/databases/(default)/documents/proveedores/${proveedor.id}'); //Endpoint de la base de datos, para borrar por ID

    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;
    print(decodeResp);

    if (response.statusCode == 200) {
      proveedores.removeWhere((element) => element.id == proveedor.id);
      notifyListeners();
    }
  }
}
