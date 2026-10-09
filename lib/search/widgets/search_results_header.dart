import 'package:flutter/material.dart';
import 'package:nutriplato/config/theme/design_system.dart';

class SearchResultsHeader extends StatelessWidget {
  final int resultCount;
  final String sortLabel;
  final VoidCallback onSortTap;

  const SearchResultsHeader({
    super.key,
    required this.resultCount,
    required this.sortLabel,
    required this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.list_alt,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '$resultCount resultados',
                  style: AppTypography.labelLarge.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onSortTap,
            borderRadius: BorderRadius.circular(AppRadius.full),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.full),
                boxShadow: [AppShadows.subtle],
              ),
              child: Row(
                children: [
                  Icon(Icons.sort, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    sortLabel,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
