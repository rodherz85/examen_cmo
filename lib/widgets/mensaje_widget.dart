import 'package:examen_cmo/theme/theme.dart';

//Este es un widget permite enviar un mensaje tipo Snackbar cuando se crea un nuevo, producto, categoría o proveedor
class MensajeWidget {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: MyTheme.secundary),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        action: SnackBarAction(
            label: 'OK', textColor: MyTheme.primary, onPressed: () {}),
      ),
    );
  }
}
