import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/pages/settings_page.dart";
import "package:khookbook/pages/edit_profile_page.dart";
import "package:khookbook/pages/admin_page.dart";
import "package:khookbook/providers/auth_provider.dart";
import "package:khookbook/providers/admin_provider.dart";
import "package:khookbook/widgets/status_banner.dart";
import "package:khookbook/widgets/halal_stats_widget.dart";

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfilePage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Show verification banner if user is not verified
          if (auth != null && !auth.emailVerified)
            StatusBanner(
              message:
                  "Your email is not verified. Verify to access all features.",
              type: BannerType.warning,
              actionLabel: "Verify Now",
              onAction: () => ref
                  .read(authProvider.notifier)
                  .sendVerificationEmail(context),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor:
                                theme.colorScheme.secondaryContainer,
                            child: Text(
                              auth?.email?.characters.first.toUpperCase() ??
                                  "U",
                              style: theme.textTheme.headlineMedium,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(Icons.camera_alt, size: 20),
                              style: IconButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        auth?.email ?? "User",
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Member since ${auth?.metadata.creationTime?.year ?? 2024}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _SectionHeader(title: "Halal Verification"),
                const HalalStatsWidget(),
                const SizedBox(height: 16),
                _SectionHeader(title: "Account"),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text("Personal Information"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.security_outlined),
                  title: const Text("Change Password"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showChangePasswordDialog(context, ref),
                ),
                ListTile(
                  leading: const Icon(Icons.delete_forever),
                  title: const Text("Delete Account"),
                  subtitle: const Text("This action cannot be undone"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showDeleteAccountDialog(context, ref),
                ),
                _SectionHeader(title: "Preferences"),
                ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text("Notifications"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text("Settings"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final isAdmin = ref.watch(adminProvider);
                    return isAdmin.when(
                      data: (isAdmin) => isAdmin
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const _SectionHeader(title: "Admin"),
                                ListTile(
                                  leading: const Icon(
                                    Icons.admin_panel_settings,
                                  ),
                                  title: const Text("Admin Dashboard"),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AdminPage.id,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FilledButton.tonal(
                    onPressed: () =>
                        ref.read(authProvider.notifier).signOut(context),
                    child: const Text("Sign Out"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context, WidgetRef ref) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Password"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: "Current Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your current password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: "New Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a new password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ref
                    .read(authProvider.notifier)
                    .changePassword(
                      context,
                      currentPassword: currentPasswordController.text,
                      newPassword: newPasswordController.text,
                    );
                Navigator.pop(context);
              }
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "This action cannot be undone. Please enter your password to confirm.",
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ref
                    .read(authProvider.notifier)
                    .deleteAccount(context, passwordController.text);
                Navigator.pop(context);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
