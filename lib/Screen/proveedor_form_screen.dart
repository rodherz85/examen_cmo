import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProveedorFormScreen extends StatelessWidget {
  final bool isUpdateMode;
  final ProvListModel? proveedor;

  const ProveedorFormScreen(
      {super.key, required this.isUpdateMode, this.proveedor});
  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    final proveedorFormProvider = Provider.of<ProveedorFormProvider>(context);

    if (proveedor != null) {
      proveedorFormProvider.proveedor = proveedor!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear/Editar Proveedor'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: proveedorFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFieldWidget(
                label: 'Nombre',
                initialValue: proveedorFormProvider.proveedor.nombre,
                onChanged: (value) => proveedorFormProvider.proveedor =
                    proveedorFormProvider.proveedor
                        .copiarProveedor(nombre: value),
              ),
              TextFieldWidget(
                label: 'Dirección',
                initialValue: proveedorFormProvider.proveedor.direccion,
                onChanged: (value) => proveedorFormProvider.proveedor =
                    proveedorFormProvider.proveedor
                        .copiarProveedor(direccion: value),
              ),
              TextFieldWidget(
                label: 'Teléfono',
                initialValue: proveedorFormProvider.proveedor.telefono,
                onChanged: (value) => proveedorFormProvider.proveedor =
                    proveedorFormProvider.proveedor.copiarProveedor(
                  telefono: value,
                ),
              ),
              TextFieldWidget(
                label: 'Categoría',
                initialValue: proveedorFormProvider.proveedor.categoria,
                onChanged: (value) => proveedorFormProvider.proveedor =
                    proveedorFormProvider.proveedor.copiarProveedor(
                  categoria: value,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!proveedorFormProvider.isValidForm()) return;
                  if (isUpdateMode) {
                    await proveedorService
                        .updateProveedor(proveedorFormProvider.proveedor);
                  } else {
                    await proveedorService
                        .createProveedor(proveedorFormProvider.proveedor);
                  }
                  await proveedorService.loadProveedores();
                  MensajeWidget.showSnackBar(
                      context, 'Proveedor agregado exitosamente');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'proveedores', (Route<dynamic> route) => false);
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(MyTheme.primary),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
