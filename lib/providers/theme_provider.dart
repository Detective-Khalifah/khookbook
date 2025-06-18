import "package:flutter/material.dart" show ThemeMode;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:khookbook/providers/settings_provider.dart";

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final prefsBox = ref.watch(prefsProvider);
  final appPrefs = prefsBox.get(SettingsNotifier.appPrefsKey);
  final initialThemeMode = appPrefs?.themeMode ?? ThemeMode.system;
  return ThemeNotifier(ref, initialThemeMode);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref _ref;
  ThemeNotifier(this._ref, ThemeMode initialThemeMode)
    : super(initialThemeMode);

  Future<void> setTheme(ThemeMode newTheme) async {
    if (state != newTheme) {
      state = newTheme;
      // Persist the theme using SettingsNotifier
      await _ref.read(settingsProvider.notifier).setThemeModeInPrefs(newTheme);
    }
  }
}
