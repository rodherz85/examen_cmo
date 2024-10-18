import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProveedoresScreen extends StatefulWidget {
  const ProveedoresScreen({super.key});

  @override
  _ProveedoresScreenState createState() => _ProveedoresScreenState();
}

class _ProveedoresScreenState extends State<ProveedoresScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    if (proveedorService.isLoading) return const LoadingScreen();

    final filteredProveedores = proveedorService.proveedores.where((proveedor) {
      return proveedor.nombre.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Listado de Proveedores'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: MyTheme.secundary,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchField(
                  hintText: 'Buscar proveedores...',
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                )),
          ),
        ),
        body: ListView.separated(
          itemCount: filteredProveedores.length,
          itemBuilder: (context, index) {
            final proveedor = filteredProveedores[index];
            return ListTile(
              selectedColor: Colors.black,
              leading: const Icon(
                Icons.store_mall_directory,
                color: MyTheme.primary,
                size: 30,
              ),
              title: Text(
                proveedor.nombre.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Dirección: ${proveedor.direccion}\nTeléfono:  ${proveedor.telefono}',
                style: const TextStyle(color: Colors.black),
              ),
              trailing: Text(
                'Categoría: ${proveedor.categoria.toUpperCase()}',
                style: const TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'detail_proveedor',
                    arguments: proveedor);
              },
            );
          },
          separatorBuilder: (_, __) => const Divider(),
        ),
        floatingActionButton: FloatButton(onPressed: () {
          proveedorService.SelectProveedor = ProvListModel(
              id: '',
              nombre: '',
              categoria: '',
              telefono: '',
              direccion: ''); // Reset SelectProduct
          Navigator.pushNamed(context, 'create_proveedor');
        }));
  }
}
