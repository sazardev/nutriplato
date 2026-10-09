import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/food/custom_food_provider.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:provider/provider.dart';

class CreateFoodDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController caloriesController;
  final TextEditingController proteinController;
  final TextEditingController carbsController;
  final TextEditingController fatController;
  final TextEditingController portionController;

  const CreateFoodDialog({
    super.key,
    required this.nameController,
    required this.caloriesController,
    required this.proteinController,
    required this.carbsController,
    required this.fatController,
    required this.portionController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear alimento'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre *',
                hintText: 'Ej. Smoothie de fresa',
              ),
            ),
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Calorías por porción *',
              ),
            ),
            TextField(
              controller: proteinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Proteínas (g)'),
            ),
            TextField(
              controller: carbsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Carbohidratos (g)'),
            ),
            TextField(
              controller: fatController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Grasas (g)'),
            ),
            TextField(
              controller: portionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso por porción (g)',
                hintText: '100',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}

Future<void> showCreateFoodDialog(
  BuildContext context, {
  required VoidCallback onCreated,
}) async {
  final nameController = TextEditingController();
  final caloriesController = TextEditingController();
  final proteinController = TextEditingController();
  final carbsController = TextEditingController();
  final fatController = TextEditingController();
  final portionController = TextEditingController();

  final created = await showDialog<bool>(
    context: context,
    builder: (ctx) => CreateFoodDialog(
      nameController: nameController,
      caloriesController: caloriesController,
      proteinController: proteinController,
      carbsController: carbsController,
      fatController: fatController,
      portionController: portionController,
    ),
  );

  if (created != true || !context.mounted) return;

  final name = nameController.text.trim();
  final calories = double.tryParse(caloriesController.text.trim());
  if (name.isEmpty || calories == null) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nombre y calorías son obligatorios')),
    );
    return;
  }

  final food = Food(
    name: name,
    category: 'custom',
    icon: const Icon(Icons.restaurant, color: Colors.green),
    color: Colors.green,
    cantidadSugerida: '1',
    unidad: 'porción',
    pesoRedondeado: portionController.text.trim().isEmpty
        ? '100'
        : portionController.text.trim(),
    pesoNeto: portionController.text.trim().isEmpty
        ? '100'
        : portionController.text.trim(),
    energia: calories.toStringAsFixed(0),
    proteina: (double.tryParse(proteinController.text.trim()) ?? 0)
        .toStringAsFixed(1),
    lipidos: (double.tryParse(fatController.text.trim()) ?? 0).toStringAsFixed(
      1,
    ),
    hidratosDeCarbono: (double.tryParse(carbsController.text.trim()) ?? 0)
        .toStringAsFixed(1),
  );

  await context.read<CustomFoodProvider>().addFood(food);
  if (!context.mounted) return;
  onCreated();
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('"$name" agregado a tus alimentos')));
}
