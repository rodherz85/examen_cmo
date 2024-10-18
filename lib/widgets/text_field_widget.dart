import 'package:flutter/material.dart';

//Este es un widget que crea un textField personalizado y reutilizable

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String initialValue;
  final Function(String) onChanged;
  final TextInputType keyboardType;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          if (keyboardType == TextInputType.number &&
              int.tryParse(value) == null) {
            return 'Ingrese un número válido';
          }
          return null;
        },
      ),
    );
  }
}
