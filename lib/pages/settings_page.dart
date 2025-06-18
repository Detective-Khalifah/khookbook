import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/providers/theme_provider.dart";
import "package:khookbook/providers/settings_provider.dart";

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentTheme = ref.watch(themeProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ListView(
          children: [
            _SectionHeader(title: "Appearance"),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text("Light"),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text("Dark"),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text("Auto"),
                  icon: Icon(Icons.brightness_auto),
                ),
              ],
              selected: {currentTheme},
              onSelectionChanged: (newSelection) {
                if (newSelection.isNotEmpty) {
                  ref.read(themeProvider.notifier).setTheme(newSelection.first);
                }
              },
              emptySelectionAllowed: false,
              multiSelectionEnabled: false,
            ),
            _SectionHeader(title: "Food Preferences"),
            SwitchListTile(
              title: const Text("Halal Filter"),
              subtitle: const Text(
                "Hide recipes containing non-halal ingredients",
              ),
              value: settings.halalFilterEnabled,
              onChanged: (value) =>
                  ref.read(settingsProvider.notifier).toggleHalalFilter(value),
            ),
            _SectionHeader(title: "Notifications"),
            SwitchListTile(
              title: const Text("Push Notifications"),
              subtitle: const Text("Get recipe updates and recommendations"),
              value: settings.notificationsEnabled,
              onChanged: (value) => ref
                  .read(settingsProvider.notifier)
                  .toggleNotifications(value),
            ),
            _SectionHeader(title: "App Settings"),
            ListTile(
              title: const Text("Language"),
              subtitle: const Text("English"),
              leading: const Icon(Icons.language),
              onTap: () {},
            ),
            _SectionHeader(title: "About"),
            ListTile(
              title: const Text("Version"),
              subtitle: const Text("1.0.0"),
              leading: const Icon(Icons.info_outline),
            ),
            ListTile(
              title: const Text("Terms of Service"),
              leading: const Icon(Icons.description_outlined),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Privacy Policy"),
              leading: const Icon(Icons.privacy_tip_outlined),
              onTap: () {},
            ),
          ],
        ),
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
