class ListadoProductos {
  final List<ProductListModel> listadoProductos;

  ListadoProductos({required this.listadoProductos});

  factory ListadoProductos.fromJson(Map<String, dynamic> json) {
    final List<dynamic> productosJson = json['documents'] as List<dynamic>;

    return ListadoProductos(
      listadoProductos: productosJson.map((producto) {
        final data = producto['fields'];
        return ProductListModel.fromMap({
          'id': producto['name'].split('/').last, //
          'descripcion': data['descripcion']['stringValue'],
          'nombre': data['nombre']['stringValue'],
          'precio': int.parse(data['precio']['integerValue']),
          'stock': int.parse(data['stock']['integerValue']),
        });
      }).toList(),
    );
  }
}

class ProductListModel {
  final String id;
  final String descripcion;
  final String nombre;
  final int precio;
  final int stock;

  ProductListModel({
    required this.id,
    required this.descripcion,
    required this.nombre,
    required this.precio,
    required this.stock,
  });

  ProductListModel copiarProducto({
    String? id,
    String? descripcion,
    String? nombre,
    int? precio,
    int? stock,
  }) {
    return ProductListModel(
      id: id ??
          this.id, // Usa el nuevo id si se proporciona, de lo contrario, usa el actual
      descripcion: descripcion ?? this.descripcion,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      stock: stock ?? this.stock,
    );
  }

  factory ProductListModel.fromMap(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id'] ?? '',
      descripcion: json['descripcion'] ?? '',
      nombre: json['nombre'] ?? '',
      precio: int.parse(
          json['precio']?.toString() ?? '0'), // Manejo de posibles null
      stock: int.parse(
          json['stock']?.toString() ?? '0'), // Manejo de posibles null
    );
  }
}
