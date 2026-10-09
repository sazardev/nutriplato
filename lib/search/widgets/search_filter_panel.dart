import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/config/theme/design_system.dart';

class SearchFilterPanel extends StatelessWidget {
  final RangeValues caloriesRange;
  final RangeValues proteinRange;
  final ValueChanged<RangeValues> onCaloriesChanged;
  final ValueChanged<RangeValues> onProteinChanged;
  final VoidCallback onReset;
  final VoidCallback onApply;

  const SearchFilterPanel({
    super.key,
    required this.caloriesRange,
    required this.proteinRange,
    required this.onCaloriesChanged,
    required this.onProteinChanged,
    required this.onReset,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [AppShadows.card],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune, color: Theme.of(context).primaryColor),
              const SizedBox(width: AppSpacing.sm),
              Text('Filtros Avanzados', style: AppTypography.titleMedium),
            ],
          ),
          const Divider(height: AppSpacing.lg),
          SearchRangeFilterSection(
            title: 'Calorías',
            icon: Icons.local_fire_department,
            iconColor: Colors.orange,
            currentRange: caloriesRange,
            maxRange: 1000,
            unit: 'kcal',
            onChanged: onCaloriesChanged,
          ),
          const SizedBox(height: AppSpacing.md),
          SearchRangeFilterSection(
            title: 'Proteínas',
            icon: FontAwesomeIcons.dna.data,
            iconColor: Colors.green,
            currentRange: proteinRange,
            maxRange: 100,
            unit: 'g',
            onChanged: onProteinChanged,
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onReset,
                  icon: const Icon(Icons.restore),
                  label: Text('Restablecer', style: AppTypography.labelLarge),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                ElevatedButton.icon(
                  onPressed: onApply,
                  icon: const Icon(Icons.check),
                  label: Text(
                    'Aplicar',
                    style: AppTypography.labelLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchRangeFilterSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final RangeValues currentRange;
  final double maxRange;
  final String unit;
  final Function(RangeValues) onChanged;

  const SearchRangeFilterSection({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.currentRange,
    required this.maxRange,
    required this.unit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: AppSpacing.sm),
            Text(title, style: AppTypography.titleSmall),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: iconColor.withValues(alpha: .3)),
              ),
              child: Text(
                '${currentRange.start.round()} $unit',
                style: AppTypography.labelLarge.copyWith(
                  color: iconColor.withValues(alpha: .8),
                ),
              ),
            ),
            Text('hasta', style: AppTypography.bodySmall),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: iconColor.withValues(alpha: .3)),
              ),
              child: Text(
                '${currentRange.end.round()} $unit',
                style: AppTypography.labelLarge.copyWith(
                  color: iconColor.withValues(alpha: .8),
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: iconColor,
            inactiveTrackColor: iconColor.withValues(alpha: .2),
            thumbColor: iconColor,
            overlayColor: iconColor.withValues(alpha: .2),
            trackHeight: 4.0,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 6.0,
              elevation: 4.0,
            ),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
          ),
          child: RangeSlider(
            values: currentRange,
            max: maxRange,
            divisions: 20,
            labels: RangeLabels(
              '${currentRange.start.round()} $unit',
              '${currentRange.end.round()} $unit',
            ),
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: AppTypography.bodySmall),
              Text('${(maxRange / 4).round()}', style: AppTypography.bodySmall),
              Text('${(maxRange / 2).round()}', style: AppTypography.bodySmall),
              Text(
                '${(maxRange * 3 / 4).round()}',
                style: AppTypography.bodySmall,
              ),
              Text('${maxRange.round()}', style: AppTypography.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchFilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const SearchFilterChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: color.withValues(alpha: .5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(Icons.close, size: 14, color: color),
          ],
        ),
      ),
    );
  }
}
