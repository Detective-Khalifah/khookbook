import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BannerType { offline, unverified, warning }

class StatusBanner extends ConsumerWidget {
  final BannerType type;
  final String message;
  final VoidCallback? action;
  final String? actionLabel;

  const StatusBanner({
    super.key,
    required this.type,
    required this.message,
    this.action,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Material(
      child: MaterialBanner(
        content: Text(message),
        backgroundColor: _getBackgroundColor(theme),
        contentTextStyle: TextStyle(color: _getTextColor(theme)),
        leading: Icon(_getIcon(), color: _getTextColor(theme)),
        actions: [
          if (action != null && actionLabel != null)
            TextButton(
              onPressed: action,
              child: Text(
                actionLabel!,
                style: TextStyle(color: _getTextColor(theme)),
              ),
            ),
          if (type != BannerType.unverified)
            TextButton(
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: Text(
                'Dismiss',
                style: TextStyle(color: _getTextColor(theme)),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (type) {
      case BannerType.offline:
        return Icons.cloud_off;
      case BannerType.unverified:
        return Icons.warning_amber;
      case BannerType.warning:
        return Icons.warning;
    }
  }

  Color _getBackgroundColor(ThemeData theme) {
    switch (type) {
      case BannerType.offline:
        return theme.colorScheme.errorContainer;
      case BannerType.unverified:
        return theme.colorScheme.tertiaryContainer;
      case BannerType.warning:
        return theme.colorScheme.secondaryContainer;
    }
  }

  Color _getTextColor(ThemeData theme) {
    switch (type) {
      case BannerType.offline:
        return theme.colorScheme.onErrorContainer;
      case BannerType.unverified:
        return theme.colorScheme.onTertiaryContainer;
      case BannerType.warning:
        return theme.colorScheme.onSecondaryContainer;
    }
  }
}
