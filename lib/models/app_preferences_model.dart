import "package:flutter/material.dart" show ThemeMode;
import "package:hive_ce/hive.dart";

class AppPreferences extends HiveObject {
  bool notificationsEnabled;

  bool halalFilterEnabled;

  String language;

  ThemeMode themeMode;

  AppPreferences({
    this.notificationsEnabled = true,
    this.halalFilterEnabled = true,
    this.language = "English",
    this.themeMode = ThemeMode.system,
  });
}

/*
class ThemeMode extends HiveObject {
  final ThemeMode mode;
  ThemeMode(this.mode);

  static const int system = 0;

  static const int light = 1;

  static const int dark = 2;

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is ThemeMode &&
  //         runtimeType == other.runtimeType &&
  //         mode == other.mode;

  // @override
  // int get hashCode => mode.hashCode;

  // @override
  // String toString() {
  //   switch (mode) {
  //     case ThemeMode.system:
  //       return "System";
  //     case ThemeMode.light:
  //       return "Light";
  //     case ThemeMode.dark:
  //       return "Dark";
  //     default:
  //       return "Unknown";
  //   }
  // }

  // ThemeMode copyWith({ThemeMode? newMode}) {
  //   return ThemeMode(newMode ?? mode);
  // }
}
*/
