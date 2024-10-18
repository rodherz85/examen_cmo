class ListadoCategorias {
  final List<CatListModel> listadoCategorias;

  ListadoCategorias({required this.listadoCategorias});

  factory ListadoCategorias.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categoriasJson = json['documents'] as List<dynamic>;

    return ListadoCategorias(
      listadoCategorias: categoriasJson.map((categoria) {
        final data = categoria['fields'];
        return CatListModel.fromMap({
          'id': categoria['name'].split('/').last, //
          'codigo': data['codigo']['stringValue'],
          'nombre': data['nombre']['stringValue'],
          'estado': data['estado']['stringValue'],
        });
      }).toList(),
    );
  }
}

class CatListModel {
  final String id;
  final String codigo;
  final String nombre;
  final String estado;

  CatListModel({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.estado,
  });

  CatListModel copiarCategoria({
    String? id,
    String? codigo,
    String? nombre,
    String? estado,
  }) {
    return CatListModel(
      id: id ??
          this.id, // Usa el nuevo id si se proporciona, de lo contrario, usa el actual
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      estado: estado ?? this.estado,
    );
  }

  factory CatListModel.fromMap(Map<String, dynamic> json) {
    return CatListModel(
      id: json['id'] ?? '',
      codigo: json['codigo'] ?? '',
      nombre: json['nombre'] ?? '',
      estado: json['estado'] ?? '', // Manejo de posibles null
    );
  }
}
