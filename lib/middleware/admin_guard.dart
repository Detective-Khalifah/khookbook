/// AdminGuard middleware handles access control for admin-only routes and features.
/// It works with Firebase custom claims to verify admin status and provides
/// a consistent unauthorized access UI.
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/providers/admin_provider.dart";

/// Middleware class that handles admin authentication and route protection
class AdminGuard {
  /// Checks if the current user has admin privileges.
  /// Returns true if the user is an admin, false otherwise.
  /// This method is asynchronous as it needs to verify Firebase custom claims.
  ///
  /// Example usage:
  /// ```dart
  /// if (await AdminGuard.canActivate(context, ref)) {
  ///   // Show admin content
  /// } else {
  ///   // Show unauthorized message
  /// }
  /// ```
  ///
  /// @param context The BuildContext for the current widget
  /// @param ref The WidgetRef for accessing providers
  /// @return Future<bool> that resolves to true if user is admin
  static Future<bool> canActivate(BuildContext context, WidgetRef ref) async {
    final isAdmin = await ref.read(adminProvider.future);
    return isAdmin;
  }

  /// Returns a standardized widget to display when unauthorized access is attempted.
  /// This provides a consistent user experience across the app when non-admin users
  /// try to access protected routes or features.
  ///
  /// The widget includes:
  /// - An admin icon with error color
  /// - A clear error message
  /// - Explanatory text
  /// - A "Go Back" button for navigation
  ///
  /// Example usage:
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return isAdmin ? AdminPage() : AdminGuard.onUnauthorized(context);
  /// }
  /// ```
  ///
  /// @param context The BuildContext for theming and navigation
  /// @return Widget displaying the unauthorized access message
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
