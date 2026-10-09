import 'package:flutter/material.dart';

/// Muestra el aviso de que la edición de perfil estará disponible pronto.
void showEditProfileDialog(BuildContext context) {
  // Implementar diálogo de edición
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Función de edición próximamente')),
  );
}
