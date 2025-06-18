import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

enum BannerType { warning, error, info }

class StatusBanner extends ConsumerWidget {
  final String message;
  final BannerType type;
  final VoidCallback? onAction;
  final String? actionLabel;

  const StatusBanner({
    super.key,
    required this.message,
    this.type = BannerType.info,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (type) {
      case BannerType.warning:
        backgroundColor = theme.colorScheme.errorContainer;
        textColor = theme.colorScheme.onErrorContainer;
        icon = Icons.warning_rounded;
        break;
      case BannerType.error:
        backgroundColor = theme.colorScheme.error;
        textColor = theme.colorScheme.onError;
        icon = Icons.error_outline;
        break;
      case BannerType.info:
      default:
        backgroundColor = theme.colorScheme.tertiaryContainer;
        textColor = theme.colorScheme.onTertiaryContainer;
        icon = Icons.info_outline;
    }

    return Material(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(foregroundColor: textColor),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
