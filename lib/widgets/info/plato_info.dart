import 'package:flutter/material.dart';

class Plato extends StatelessWidget {
  const Plato({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Plato del buen comer'),
      content: Text('El plato del buen comer es'),
    );
  }
}
