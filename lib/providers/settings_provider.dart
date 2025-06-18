import "package:flutter/material.dart" show ThemeMode;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:khookbook/models/app_preferences_model.dart";

final prefsProvider = Provider<Box<AppPreferences>>((ref) {
  final preferencesBox = Hive.isBoxOpen("app_preference")
      ? Hive.box<AppPreferences>("app_preference")
      : throw HiveError("Box \"app_preference\" is not open");
  return preferencesBox;
});

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((
  ref,
) {
  return SettingsNotifier(ref.watch(prefsProvider));
});

class AppSettings {
  final bool notificationsEnabled;
  final bool halalFilterEnabled;
  final String language;
  final bool autoPlayVideos;

  AppSettings({
    this.notificationsEnabled = true,
    this.halalFilterEnabled = true,
    this.language = "English",
    this.autoPlayVideos = true,
  });

  AppSettings copyWith({
    bool? notificationsEnabled,
    bool? halalFilterEnabled,
    String? language,
    bool? autoPlayVideos,
  }) {
    return AppSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      halalFilterEnabled: halalFilterEnabled ?? this.halalFilterEnabled,
      language: language ?? this.language,
      autoPlayVideos: autoPlayVideos ?? this.autoPlayVideos,
    );
  }
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  final Box<AppPreferences> _prefsBox;
  static const String appPrefsKey = "user_app_preference";

  SettingsNotifier(this._prefsBox) : super(AppSettings()) {
    _loadSettings();
  }

  Future<AppPreferences> _getAppPreferences() async {
    AppPreferences? prefs = _prefsBox.get(appPrefsKey);
    if (prefs == null) {
      prefs =
          AppPreferences(); // Uses default values from AppPreferences constructor
      await _prefsBox.put(appPrefsKey, prefs);
    }
    return prefs;
  }

  Future<void> _loadSettings() async {
    final prefs = await _getAppPreferences();
    state = AppSettings(
      // notificationsEnabled: _prefsBox.get(
      //   "notifications_enabled",
      //   defaultValue: true,
      // ),
      // halalFilterEnabled: _prefsBox.get(
      //   "halal_filter_enabled",
      //   defaultValue: true,
      // ),
      // language: _prefsBox.get("language", defaultValue: "English"),
      notificationsEnabled: prefs.notificationsEnabled,
      halalFilterEnabled: prefs.halalFilterEnabled,
      language: prefs.language,

      // autoPlayVideos will use its default from AppSettings constructor
      // as it"s not in AppPreferences model yet.
    );
  }

  Future<void> toggleNotifications(bool value) async {
    // await _prefsBox.put("notifications_enabled", value);
    // state = state.copyWith(notificationsEnabled: value);
    final prefs = await _getAppPreferences();
    prefs.notificationsEnabled = value;
    await prefs.save(); // AppPreferences extends HiveObject
    state = state.copyWith(notificationsEnabled: value);
  }

  Future<void> toggleHalalFilter(bool value) async {
    // await _prefsBox.put("halal_filter_enabled", value);
    final prefs = await _getAppPreferences();
    prefs.halalFilterEnabled = value;
    await prefs.save(); // AppPreferences extends HiveObject
    state = state.copyWith(halalFilterEnabled: value);
  }

  Future<void> setLanguage(String newLanguage) async {
    final prefs = await _getAppPreferences();
    prefs.language = newLanguage;
    await prefs.save();
    state = state.copyWith(language: newLanguage);
  }

  Future<void> setThemeModeInPrefs(ThemeMode newThemeMode) async {
    final prefs = await _getAppPreferences();
    prefs.themeMode = newThemeMode;
    await prefs.save();
    // No AppSettings state update for themeMode here,
    // as AppSettings doesn"t store it. ThemeNotifier handles UI theme state.
  }
}
