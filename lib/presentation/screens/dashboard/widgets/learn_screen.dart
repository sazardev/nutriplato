import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/example_hands_screen.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/plato_info_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with reduced padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: const Text(
            'Aprende de nutrición',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Wrap the horizontal list in Expanded to use remaining space
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            children: [
              _buildLearnCard(
                context,
                'Plato del bien comer',
                'Aprende sobre la alimentación balanceada',
                Icons.restaurant_menu,
                Colors.green,
                () => Get.to(() => const PlatoInformationScreen()),
              ),
              _buildLearnCard(
                context,
                'Método de la mano',
                'Un método práctico para medir porciones',
                Icons.back_hand,
                Colors.orange,
                () => Get.to(() => const ExampleHandScreen()),
              ),
              // Additional cards can be added here
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLearnCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon area with reduced height
              Container(
                color: color.withOpacity(0.2),
                height: 85, // Reduced height
                child: Center(
                  child: Icon(
                    icon,
                    size: 50,
                    color: color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
