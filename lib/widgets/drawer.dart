import 'package:flutter/material.dart';

class DrawerProfile extends StatelessWidget {
  const DrawerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Text('Encabezado del Drawer'),
          ),
          ListTile(
            title: const Text('Opción 1'),
            onTap: () {
              // Aquí puedes agregar la funcionalidad para la opción 1
            },
          ),
          ListTile(
            title: const Text('Opción 2'),
            onTap: () {
              // Aquí puedes agregar la funcionalidad para la opción 2
            },
          ),
        ],
      ),
    );
  }
}
