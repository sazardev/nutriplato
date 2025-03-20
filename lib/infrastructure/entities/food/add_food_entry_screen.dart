import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:nutriplato/search/search.screen.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddFoodEntryScreen extends StatefulWidget {
  final DateTime selectedDate;

  const AddFoodEntryScreen({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<AddFoodEntryScreen> createState() => _AddFoodEntryScreenState();
}

class _AddFoodEntryScreenState extends State<AddFoodEntryScreen> {
  Food? _selectedFood;
  double _quantity = 1.0;
  String _mealType = 'Desayuno';
  final List<String> _mealTypes = ['Desayuno', 'Almuerzo', 'Cena', 'Snack'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar alimento'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMealTypeSelector(),
          const SizedBox(height: 16),
          _buildFoodSelector(),
          if (_selectedFood != null) ...[
            const SizedBox(height: 16),
            _buildFoodDetails(),
            const SizedBox(height: 16),
            _buildQuantitySelector(),
            const SizedBox(height: 24),
            _buildNutritionSummary(),
          ],
          const SizedBox(height: 24),
          _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildMealTypeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tipo de comida',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _mealTypes.map((type) {
                final bool isSelected = type == _mealType;
                final IconData icon = _getMealTypeIcon(type);

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    avatar: Icon(
                      icon,
                      size: 18,
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _mealType = type;
                        });
                      }
                    },
                    backgroundColor: Colors.grey.shade200,
                    selectedColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getMealTypeIcon(String type) {
    switch (type) {
      case 'Desayuno':
        return FontAwesomeIcons.mugSaucer;
      case 'Almuerzo':
        return FontAwesomeIcons.bowlFood;
      case 'Cena':
        return FontAwesomeIcons.utensils;
      case 'Snack':
        return FontAwesomeIcons.apple;
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }

  Widget _buildFoodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alimento',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () async {
              final result = await Navigator.push<Food>(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );

              if (result != null) {
                setState(() {
                  _selectedFood = result;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _selectedFood == null
                        ? const Text('Buscar y seleccionar un alimento')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedFood!.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${_selectedFood!.cantidadSugerida} ${_selectedFood!.unidad} · ${_selectedFood!.energia} kcal',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const Icon(Icons.search),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodDetails() {
    if (_selectedFood == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _selectedFood!.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _selectedFood!.color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedFood!.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedFood!.icon,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedFood!.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      _selectedFood!.category,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNutrientBox(
                label: 'Calorías',
                value: _selectedFood!.energia,
                unit: 'kcal',
                icon: Icons.local_fire_department,
                color: Colors.red,
              ),
              _buildNutrientBox(
                label: 'Proteínas',
                value: _selectedFood!.proteina,
                unit: 'g',
                icon: FontAwesomeIcons.dna,
                color: Colors.green,
              ),
              _buildNutrientBox(
                label: 'Carbohidratos',
                value: _selectedFood!.hidratosDeCarbono,
                unit: 'g',
                icon: FontAwesomeIcons.breadSlice,
                color: Colors.amber,
              ),
              _buildNutrientBox(
                label: 'Grasas',
                value: _selectedFood!.lipidos,
                unit: 'g',
                icon: FontAwesomeIcons.oilWell,
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientBox({
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    if (_selectedFood == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cantidad',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (_quantity > 0.25) {
                    setState(() {
                      _quantity -= 0.25;
                    });
                  }
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: Theme.of(context).primaryColor,
              ),
              Expanded(
                child: Slider(
                  value: _quantity,
                  min: 0.25,
                  max: 5,
                  divisions: 19, // 0.25 incrementos
                  onChanged: (value) {
                    setState(() {
                      _quantity = value;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_quantity < 5) {
                    setState(() {
                      _quantity += 0.25;
                    });
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          Center(
            child: Text(
              '$_quantity ${_selectedFood!.unidad}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummary() {
    if (_selectedFood == null) return const SizedBox.shrink();

    // Calcular nutrientes ajustados por cantidad
    final double calories = double.parse(_selectedFood!.energia) * _quantity;
    final double protein = double.parse(_selectedFood!.proteina) * _quantity;
    final double carbs =
        double.parse(_selectedFood!.hidratosDeCarbono) * _quantity;
    final double fat = double.parse(_selectedFood!.lipidos) * _quantity;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumen nutricional',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          _buildNutrientRow(
            label: 'Calorías',
            value: calories.toStringAsFixed(1),
            unit: 'kcal',
            icon: Icons.local_fire_department,
            color: Colors.red,
          ),
          const Divider(),
          _buildNutrientRow(
            label: 'Proteínas',
            value: protein.toStringAsFixed(1),
            unit: 'g',
            icon: FontAwesomeIcons.dna,
            color: Colors.green,
          ),
          const SizedBox(height: 8),
          _buildNutrientRow(
            label: 'Carbohidratos',
            value: carbs.toStringAsFixed(1),
            unit: 'g',
            icon: FontAwesomeIcons.breadSlice,
            color: Colors.amber,
          ),
          const SizedBox(height: 8),
          _buildNutrientRow(
            label: 'Grasas',
            value: fat.toStringAsFixed(1),
            unit: 'g',
            icon: FontAwesomeIcons.oilWell,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientRow({
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          '$value $unit',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: _selectedFood == null ? null : () => _addFoodEntry(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        disabledBackgroundColor: Colors.grey.shade300,
      ),
      child: const Text(
        'Agregar alimento',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _addFoodEntry() {
    if (_selectedFood == null) return;

    // Crear una entrada para el registro de alimentos
    final entry = FoodLogEntry(
      food: _selectedFood!,
      quantity: _quantity,
      timestamp: widget.selectedDate,
      mealType: _mealType,
    );

    // Agregar la entrada al proveedor
    Provider.of<FoodLogProvider>(context, listen: false).addFoodEntry(entry);

    // Mostrar un mensaje de confirmación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedFood!.name} añadido a $_mealType'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Volver a la pantalla anterior
    Navigator.pop(context);
  }
}
