import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/services/halal_verification_service.dart";

class HalalStatus extends ConsumerWidget {
  final List<String> ingredients;
  final VoidCallback? onReportPress;

  const HalalStatus({super.key, required this.ingredients, this.onReportPress});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final haramIngredients = ingredients
        .where(
          (ingredient) => HalalVerificationService.haramIngredients.any(
            (haram) => ingredient.toLowerCase().contains(haram.toLowerCase()),
          ),
        )
        .toList();

    final suspectIngredients = ingredients
        .where(
          (ingredient) => HalalVerificationService.suspectIngredients.any(
            (suspect) =>
                ingredient.toLowerCase().contains(suspect.toLowerCase()),
          ),
        )
        .toList();

    if (haramIngredients.isEmpty && suspectIngredients.isEmpty) {
      return Card(
        color: theme.colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                "No haram ingredients detected",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                icon: const Icon(Icons.flag_outlined),
                label: const Text("Report"),
                onPressed: onReportPress,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (haramIngredients.isNotEmpty) ...[
              Text(
                "Non-Halal Ingredients:",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
              const SizedBox(height: 8),
              ...haramIngredients.map(
                (ingredient) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 4),
                  child: Text(
                    "• $ingredient",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ),
            ],
            if (suspectIngredients.isNotEmpty) ...[
              if (haramIngredients.isNotEmpty) const SizedBox(height: 16),
              Text(
                "Ingredients Needing Verification:",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
              const SizedBox(height: 8),
              ...suspectIngredients.map(
                (ingredient) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 4),
                  child: Text(
                    "• $ingredient",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.flag_outlined),
                  label: const Text("Report Status"),
                  onPressed: onReportPress,
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
