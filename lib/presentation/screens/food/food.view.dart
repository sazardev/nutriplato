import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:nutriplato/presentation/home.screen.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/food/animals.dart';
import '../../../data/food/cereales.dart';
import '../../../data/food/frutas.dart';
import '../../../data/food/verduras.dart';

class FoodViewScreen extends StatefulWidget {
  final Food food;

  const FoodViewScreen({
    super.key,
    required this.food,
  });

  @override
  State<FoodViewScreen> createState() => _DisplayFoodScreen();
}

class _DisplayFoodScreen extends State<FoodViewScreen>
    with SingleTickerProviderStateMixin {
  int multiplicador = 1;
  String _selectedMealType = 'Desayuno';
  final List<String> _mealTypes = ['Desayuno', 'Almuerzo', 'Cena', 'Snack'];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<dynamic> list = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    switch (widget.food.category) {
      case "leguminosa":
        list = leguminosas;
        break;
      case "animal":
        list = animals;
        break;
      case "cereal":
        list = cereales;
        break;
      case "verdura":
        list = verduras;
        break;
      case "fruta":
        list = frutas;
        break;
    }

    controller = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = widget.food.color;
    final Color textColor =
        _isColorDark(baseColor) ? Colors.white : Colors.black87;
    final Color cardColor = _isColorDark(baseColor)
        ? Colors.white.withOpacity(0.15)
        : Colors.black.withOpacity(0.05);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            baseColor,
            baseColor.withOpacity(0.85),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar at top
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // Food Name and Icon
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconTheme(
                      data: IconThemeData(
                        color: textColor,
                        size: 32,
                      ),
                      child: widget.food.icon,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.food.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getCategoryName(widget.food.category),
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nutrition Summary Card
                        _buildNutritionCard(),

                        // Food Details Section
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Información nutricional'),
                              const SizedBox(height: 12),

                              // Serving info row
                              _buildInfoRow(
                                title: 'Porción',
                                value: multiplicador == 1
                                    ? '${widget.food.cantidadSugerida} ${widget.food.unidad} (${widget.food.pesoNeto} g)'
                                    : '${multiplicador} ${widget.food.unidad} (${(double.tryParse(widget.food.pesoNeto) ?? 0) * multiplicador} g)',
                                icon: Icons.restaurant,
                                onInfoPressed: () => _showInfoDialog('Porción',
                                    'Cantidad recomendada por porción según el Sistema Mexicano de Equivalencias.'),
                              ),

                              const SizedBox(height: 16),

                              // Servings quantity selector
                              _buildInfoRow(
                                title: 'Porciones',
                                customValue: _buildQuantitySelector(),
                                icon: Icons.add_chart,
                                onInfoPressed: () => _showInfoDialog(
                                    'Porciones',
                                    'Cantidad recomendada por el Sistema Mexicano de Equivalencias.\n\nPuedes modificar la cantidad que es la equivalencia a una porcion del alimento.'),
                              ),

                              const SizedBox(height: 16),

                              // Meal type selector
                              _buildInfoRow(
                                title: 'Tipo de comida',
                                customValue: _buildMealTypeSelector(),
                                icon: Icons.schedule,
                                onInfoPressed: () => _showInfoDialog(
                                    'Tipo de comida',
                                    'Selecciona en qué momento del día consumiste este alimento.'),
                              ),

                              const SizedBox(height: 24),

                              // Food tags section
                              _buildFoodTags(),

                              const SizedBox(height: 24),

                              // Add to log button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () => _addToCaloriesLog(context),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: widget.food.color,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 4,
                                  ),
                                  icon: const Icon(FontAwesomeIcons.plus),
                                  label: const Text(
                                    'Agregar al registro',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(String category) {
    switch (category) {
      case "leguminosa":
        return "Leguminosa";
      case "animal":
        return "Origen Animal";
      case "cereal":
        return "Cereal";
      case "verdura":
        return "Verdura";
      case "fruta":
        return "Fruta";
      default:
        return category;
    }
  }

  bool _isColorDark(Color color) {
    // Calculate luminance, if less than 0.5, the color is considered dark
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance < 0.5;
  }

  Widget _buildNutritionCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNutrientValue(
                '${(int.parse(widget.food.energia) * multiplicador)}',
                'kcal',
                'Calorías',
                FontAwesomeIcons.fire,
                Colors.red.shade400,
              ),
              _buildNutrientValue(
                '${(double.parse(widget.food.proteina) * multiplicador).toStringAsFixed(1)}',
                'g',
                'Proteínas',
                FontAwesomeIcons.dna,
                Colors.green.shade500,
              ),
              _buildNutrientValue(
                '${(double.parse(widget.food.hidratosDeCarbono) * multiplicador).toStringAsFixed(1)}',
                'g',
                'Carbohidratos',
                FontAwesomeIcons.breadSlice,
                Colors.amber.shade700,
              ),
              _buildNutrientValue(
                '${(double.parse(widget.food.lipidos) * multiplicador).toStringAsFixed(1)}',
                'g',
                'Grasas',
                FontAwesomeIcons.oilWell,
                Colors.orange.shade700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientValue(
      String value, String unit, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
            children: [
              TextSpan(text: value),
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoRow(
      {required String title,
      String? value,
      Widget? customValue,
      required IconData icon,
      required VoidCallback onInfoPressed}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.food.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: widget.food.color,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        IconButton(
          onPressed: onInfoPressed,
          icon: const Icon(
            Icons.info_outline,
            size: 18,
          ),
          color: Colors.grey.shade600,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          constraints: const BoxConstraints(),
        ),
        const Spacer(),
        if (value != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else if (customValue != null)
          customValue,
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (multiplicador > 1) {
                setState(() {
                  multiplicador--;
                  controller.text = multiplicador.toString();
                });
              }
            },
            icon: Icon(Icons.remove, color: widget.food.color),
            iconSize: 18,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          Container(
            width: 40,
            height: 36,
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.food.color,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[1-9]$|^1[0-9]$|^20$')),
              ],
              onChanged: (value) {
                if (value.isNotEmpty) {
                  final intValue = int.tryParse(value) ?? 1;
                  if (intValue > 0 && intValue <= 20) {
                    setState(() {
                      multiplicador = intValue;
                    });
                  }
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              if (multiplicador < 20) {
                setState(() {
                  multiplicador++;
                  controller.text = multiplicador.toString();
                });
              }
            },
            icon: Icon(Icons.add, color: widget.food.color),
            iconSize: 18,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _buildMealTypeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedMealType,
          icon: Icon(Icons.arrow_drop_down, color: widget.food.color),
          style: TextStyle(
            color: widget.food.color,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedMealType = newValue;
              });
            }
          },
          items: _mealTypes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getMealTypeIcon(value),
                    size: 16,
                    color: widget.food.color,
                  ),
                  const SizedBox(width: 8),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _getMealTypeIcon(String mealType) {
    switch (mealType) {
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

  Widget _buildFoodTags() {
    List<Widget> tags = [];

    // Check for high protein
    if ((double.parse(widget.food.proteina) * 4) /
            (double.parse(widget.food.energia)) *
            100 >
        20) {
      tags.add(
          _buildTag('Alto en proteínas', Colors.green.shade600, Icons.done));
    }

    // Check for high calories
    if ((double.parse(widget.food.energia) /
                double.parse(widget.food.pesoNeto)) *
            100 >=
        275) {
      tags.add(
          _buildTag('Alto en calorías', Colors.red.shade600, Icons.warning));
    }

    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags,
    );
  }

  Widget _buildTag(String text, Color color, IconData icon) {
    return InkWell(
      onTap: () => _showInfoDialog(text,
          'Este alimento tiene características nutricionales especiales que debes tener en cuenta.'),
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Entendido',
                style: TextStyle(color: widget.food.color),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addToCaloriesLog(BuildContext context) {
    // Crear una entrada para el registro de alimentos
    final entry = FoodLogEntry(
      food: widget.food,
      quantity: multiplicador.toDouble(),
      timestamp: DateTime.now(),
      mealType: _selectedMealType,
    );

    // Agregar la entrada al proveedor
    Provider.of<FoodLogProvider>(context, listen: false).addFoodEntry(entry);

    // Cerrar el modal actual
    Navigator.pop(context);

    // Detectar la fuente de la navegación
    bool fromAddFoodEntryScreen = false;
    try {
      if (Navigator.canPop(context)) {
        final route = ModalRoute.of(context);
        if (route?.settings.name == 'AddFoodEntryScreen') {
          fromAddFoodEntryScreen = true;
        }
      }
    } catch (e) {
      // Ignorar errores de navegación
      print('Error al detectar pantalla: $e');
    }

    if (fromAddFoodEntryScreen) {
      // Si venimos de la pantalla de agregar alimento, navegar directamente
      // Primero cerramos todas las ventanas modales
      Navigator.of(context).popUntil((route) => route.isFirst);
      // Luego navegamos a HomeScreen con el índice 1 (CaloriesTrackerScreen)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => const HomeScreen(), arguments: 1);
      });
    } else {
      // Si no, mostrar snackbar con opción de ver registro
      final snackBar = SnackBar(
        content: Text(
          '${widget.food.name} (${multiplicador}x) añadido a tu registro de $_selectedMealType',
        ),
        backgroundColor: widget.food.color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Ver registro',
          textColor: Colors.white,
          onPressed: () {
            // Use WidgetsBinding to run this after the current frame
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.offAll(() => const HomeScreen(), arguments: 1);
            });
          },
        ),
      );

      // Show SnackBar safely after the frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }
}
