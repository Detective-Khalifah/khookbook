import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((
  ref,
) {
  return SettingsNotifier();
});

class AppSettings {
  final bool notificationsEnabled;
  final bool emailNotifications;
  final String language;
  final bool autoPlayVideos;

  AppSettings({
    this.notificationsEnabled = true,
    this.emailNotifications = true,
    this.language = 'English',
    this.autoPlayVideos = true,
  });

  AppSettings copyWith({
    bool? notificationsEnabled,
    bool? emailNotifications,
    String? language,
    bool? autoPlayVideos,
  }) {
    return AppSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      language: language ?? this.language,
      autoPlayVideos: autoPlayVideos ?? this.autoPlayVideos,
    );
  }
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(AppSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppSettings(
      notificationsEnabled: prefs.getBool('notifications_enabled') ?? true,
      emailNotifications: prefs.getBool('email_notifications') ?? true,
      language: prefs.getString('language') ?? 'English',
      autoPlayVideos: prefs.getBool('auto_play_videos') ?? true,
    );
  }

  Future<void> toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    state = state.copyWith(notificationsEnabled: value);
  }
}
