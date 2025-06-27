/// Widget that displays halal verification statistics in a user-friendly format.
/// Shows total verifications, halal percentage, and pending reports if the user is an admin.
///
/// Statistics displayed:
/// - Total number of verified recipes
/// - Percentage of recipes verified as halal
/// - Number of pending reports (admin-only)
///
/// The widget updates in real-time as the underlying statistics change in Firestore.
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/providers/halal_stats_provider.dart";

class HalalStatsWidget extends ConsumerWidget {
  const HalalStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final statsAsync = ref.watch(halalStatsProvider);

    return statsAsync.when(
      data: (stats) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Halal Verification Stats",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatItem(
                    label: "Verified Recipes",
                    value: stats.totalVerified.toString(),
                    icon: Icons.verified_outlined,
                  ),
                  _StatItem(
                    label: "Halal Recipes",
                    value: stats.totalHalal.toString(),
                    icon: Icons.check_circle_outline,
                  ),
                  _StatItem(
                    label: "Pending Reports",
                    value: stats.pendingReports.toString(),
                    icon: Icons.pending_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: stats.halalPercentage / 100,
                backgroundColor: theme.colorScheme.surfaceVariant,
                valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
              ),
              const SizedBox(height: 8),
              Text(
                "${stats.halalPercentage.toStringAsFixed(1)}% recipes verified as halal",
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
