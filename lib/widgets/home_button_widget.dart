import 'package:flutter/material.dart';

// Boton que al presionar dirije al menú principal

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const HomeButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.blue, // O cualquier color que prefieras
          child: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
