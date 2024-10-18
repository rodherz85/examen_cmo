class ListadoProveedores {
  final List<ProvListModel> listadoProveedores;

  ListadoProveedores({required this.listadoProveedores});

  factory ListadoProveedores.fromJson(Map<String, dynamic> json) {
    final List<dynamic> proveedoresJson = json['documents'] as List<dynamic>;

    return ListadoProveedores(
      listadoProveedores: proveedoresJson.map((proveedor) {
        final data = proveedor['fields'];
        return ProvListModel.fromMap({
          'id': proveedor['name'].split('/').last, //
          'direccion': data['direccion']['stringValue'],
          'nombre': data['nombre']['stringValue'],
          'categoria': data['categoria']['stringValue'],
          'telefono': data['telefono']['stringValue'],
        });
      }).toList(),
    );
  }
}

class ProvListModel {
  final String id;
  final String direccion;
  final String nombre;
  final String categoria;
  final String telefono;

  ProvListModel({
    required this.id,
    required this.direccion,
    required this.nombre,
    required this.categoria,
    required this.telefono,
  });

  ProvListModel copiarProveedor({
    String? id,
    String? direccion,
    String? nombre,
    String? categoria,
    String? telefono,
  }) {
    return ProvListModel(
      id: id ??
          this.id, // Usa el nuevo id si se proporciona, de lo contrario, usa el actual
      direccion: direccion ?? this.direccion,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      telefono: telefono ?? this.telefono,
    );
  }

  factory ProvListModel.fromMap(Map<String, dynamic> json) {
    return ProvListModel(
      id: json['id'] ?? '',
      direccion: json['direccion'] ?? '',
      nombre: json['nombre'] ?? '',
      categoria: json['categoria'] ?? '', // Manejo de posibles null
      telefono: json['telefono'] ?? '', // Manejo de posibles null
    );
  }
}
