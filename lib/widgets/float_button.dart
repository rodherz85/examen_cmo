import 'package:examen_cmo/theme/my_theme.dart';
import 'package:flutter/material.dart';

//Botón flotante que se utiliza en productos, proveedores y categorías y permite crear un nuevo registro

class FloatButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: MyTheme.primary,
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
