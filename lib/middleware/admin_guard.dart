import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/providers/admin_provider.dart";

class AdminGuard {
  static Future<bool> canActivate(BuildContext context, WidgetRef ref) async {
    final isAdmin = await ref.read(adminProvider.future);
    return isAdmin;
  }

  static Widget onUnauthorized(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.admin_panel_settings,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              "Admin Access Required",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You do not have permission to access this page",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
