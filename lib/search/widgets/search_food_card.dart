import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/data/data.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';

class SearchFoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const SearchFoodCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color categoryColor;
    IconData categoryIcon;

    switch (food.category) {
      case 'cereal':
        categoryColor = sectionColors[0];
        categoryIcon = FontAwesomeIcons.wheatAwn.data;
        break;
      case 'leguminosa':
        categoryColor = sectionColors[1];
        categoryIcon = FontAwesomeIcons.seedling.data;
        break;
      case 'animal':
        categoryColor = sectionColors[2];
        categoryIcon = FontAwesomeIcons.cow.data;
        break;
      case 'verdura':
        categoryColor = sectionColors[4];
        categoryIcon = FontAwesomeIcons.carrot.data;
        break;
      case 'fruta':
        categoryColor = sectionColors[4];
        categoryIcon = FontAwesomeIcons.appleWhole.data;
        break;
      default:
        categoryColor = AppColors.textSecondary;
        categoryIcon = Icons.food_bank;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [AppShadows.card],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Container(
              color: categoryColor.withValues(alpha: .15),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Icon(categoryIcon, size: 14, color: categoryColor),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      food.category.substring(0, 1).toUpperCase() +
                          food.category.substring(1),
                      style: AppTypography.labelSmall.copyWith(
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Image
            Expanded(
              flex: 3,
              child: Container(
                color: categoryColor.withValues(alpha: .08),
                width: double.infinity,
                child:
                    food.image ??
                    Icon(
                      categoryIcon,
                      size: 50,
                      color: categoryColor.withValues(alpha: .4),
                    ),
              ),
            ),
            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SearchNutrientBadge(
                          'Calorías',
                          '${double.tryParse(food.energia)?.round() ?? 0}',
                          'kcal',
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        SearchNutrientBadge('Proteína', food.proteina, 'g'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchNutrientBadge extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const SearchNutrientBadge(this.label, this.value, this.unit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(fontSize: 8),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '$value $unit',
            style: AppTypography.labelSmall.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
