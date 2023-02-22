import 'package:flutter/material.dart';

void mostrarSnackBar(String message, BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(milliseconds: 2200),
    backgroundColor: const Color.fromARGB(255, 248, 2, 2),
  ));
}
