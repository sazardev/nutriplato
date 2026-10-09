import 'package:flutter/material.dart';
import 'package:nutriplato/config/theme/design_system.dart';

/// Botones de navegacion (atras / siguiente) del onboarding.
class OnboardingNavButtons extends StatelessWidget {
  const OnboardingNavButtons({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.canProceed,
    required this.onNext,
    required this.onPrevious,
  });

  final int currentPage;
  final int totalPages;
  final bool canProceed;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (currentPage > 0)
            TextButton.icon(
              onPressed: onPrevious,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text('Atras', style: TextStyle(color: Colors.white)),
            ),
          const Spacer(),
          ElevatedButton(
            onPressed: canProceed ? onNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentPage == totalPages - 1 ? 'Comenzar' : 'Siguiente',
                  style: NutriDesign.font(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  currentPage == totalPages - 1
                      ? Icons.check
                      : Icons.arrow_forward,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
