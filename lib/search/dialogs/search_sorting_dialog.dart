import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/config/theme/design_system.dart';

const List<String> _sortingMethods = [
  'Alfabético (A-Z)',
  'Alfabético (Z-A)',
  'Calorías (menor a mayor)',
  'Calorías (mayor a menor)',
  'Proteínas (menor a mayor)',
  'Proteínas (mayor a menor)',
  'Recientes primero',
];

class SearchSortingDialog extends StatefulWidget {
  final String current;
  final ValueChanged<String> onSelected;

  const SearchSortingDialog({
    super.key,
    required this.current,
    required this.onSelected,
  });

  @override
  State<SearchSortingDialog> createState() => _SearchSortingDialogState();
}

class _SearchSortingDialogState extends State<SearchSortingDialog> {
  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> sortIcons = {
      'Alfabético (A-Z)': Icons.sort_by_alpha,
      'Alfabético (Z-A)': Icons.sort,
      'Calorías (menor a mayor)': FontAwesomeIcons.fireFlameCurved.data,
      'Calorías (mayor a menor)': FontAwesomeIcons.fireFlameCurved.data,
      'Proteínas (menor a mayor)': FontAwesomeIcons.dna.data,
      'Proteínas (mayor a menor)': FontAwesomeIcons.dna.data,
      'Recientes primero': Icons.history,
    };

    final Map<String, Widget> sortDirections = {
      'Alfabético (A-Z)': const Icon(Icons.arrow_upward, size: 16),
      'Alfabético (Z-A)': const Icon(Icons.arrow_downward, size: 16),
      'Calorías (menor a mayor)': const Icon(Icons.arrow_upward, size: 16),
      'Calorías (mayor a menor)': const Icon(Icons.arrow_downward, size: 16),
      'Proteínas (menor a mayor)': const Icon(Icons.arrow_upward, size: 16),
      'Proteínas (mayor a menor)': const Icon(Icons.arrow_downward, size: 16),
      'Recientes primero': const Icon(
        Icons.star,
        size: 16,
        color: Colors.amber,
      ),
    };

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.md,
                left: AppSpacing.md,
                right: AppSpacing.md,
              ),
              child: Row(
                children: [
                  Icon(Icons.sort, color: Theme.of(context).primaryColor),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Ordenar Alimentos', style: AppTypography.titleMedium),
                ],
              ),
            ),
            const Divider(height: 1),
            SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _sortingMethods.length,
                itemBuilder: (context, index) {
                  final method = _sortingMethods[index];
                  final isSelected = widget.current == method;

                  return Material(
                    color: isSelected
                        ? Theme.of(context).primaryColor.withValues(alpha: .1)
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        widget.onSelected(method);
                      },
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                          horizontal: AppSpacing.md,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(
                                        context,
                                      ).primaryColor.withValues(alpha: .2)
                                    : AppColors.background,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.sm,
                                ),
                              ),
                              child: Icon(
                                sortIcons[method],
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : AppColors.textSecondary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                method.replaceAll(' (', '\n('),
                                style: AppTypography.bodyMedium.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            sortDirections[method] ?? Container(),
                            const SizedBox(width: AppSpacing.sm),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSearchSortingDialog(
  BuildContext context,
  String current,
  ValueChanged<String> onSelected,
) {
  showDialog(
    context: context,
    builder: (context) {
      return SearchSortingDialog(current: current, onSelected: onSelected);
    },
  );
}
