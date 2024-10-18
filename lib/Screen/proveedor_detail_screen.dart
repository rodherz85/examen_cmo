import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProveedorDetailScreen extends StatelessWidget {
  const ProveedorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final proveedor =
        ModalRoute.of(context)!.settings.arguments as ProvListModel;
    final proveedorService =
        Provider.of<ProveedorService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Proveedor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              await proveedorService.deleteProveedor(proveedor, context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'proveedores', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${proveedor.nombre}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 10),
            Text('Dirección: ${proveedor.direccion}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 10),
            Text('Teléfono: ${proveedor.telefono}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 10),
            Text('Categoría: ${proveedor.categoria}',
                style: const TextStyle(fontSize: 24, color: Colors.black)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  proveedorService.SelectProveedor = proveedor;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => ProveedorFormProvider(proveedor),
                        child: ProveedorFormScreen(
                          isUpdateMode: true,
                          proveedor: proveedor,
                        ),
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(MyTheme.primary),
                ),
                child: const Text(
                  'Editar Proveedor',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
