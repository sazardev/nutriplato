import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/config/theme/design_system.dart';

import 'search_filter_panel.dart';

class SearchActiveFiltersBar extends StatelessWidget {
  final RangeValues caloriesRange;
  final RangeValues proteinRange;
  final bool hasActiveFilters;
  final VoidCallback onClearCalories;
  final VoidCallback onClearProtein;
  final VoidCallback onClearAll;

  const SearchActiveFiltersBar({
    super.key,
    required this.caloriesRange,
    required this.proteinRange,
    required this.hasActiveFilters,
    required this.onClearCalories,
    required this.onClearProtein,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [AppShadows.subtle],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (caloriesRange.start > 0 || caloriesRange.end < 1000)
              SearchFilterChip(
                label:
                    'Calorías: ${caloriesRange.start.round()}-${caloriesRange.end.round()} kcal',
                icon: Icons.local_fire_department,
                color: Colors.orange,
                onTap: onClearCalories,
              ),
            const SizedBox(width: AppSpacing.sm),
            if (proteinRange.start > 0 || proteinRange.end < 100)
              SearchFilterChip(
                label:
                    'Proteínas: ${proteinRange.start.round()}-${proteinRange.end.round()} g',
                icon: FontAwesomeIcons.dna.data,
                color: Colors.green,
                onTap: onClearProtein,
              ),
            const SizedBox(width: AppSpacing.sm),
            if (hasActiveFilters)
              SearchFilterChip(
                label: 'Limpiar todos',
                icon: Icons.clear_all,
                color: AppColors.error,
                onTap: onClearAll,
              ),
          ],
        ),
      ),
    );
  }
}
