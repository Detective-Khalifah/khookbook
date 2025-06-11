import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff8b5000),
      surfaceTint: Color(0xff8b5000),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffff9800),
      onPrimaryContainer: Color(0xff653900),
      secondary: Color(0xff815524),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffc389),
      onSecondaryContainer: Color(0xff7a4e1e),
      tertiary: Color(0xff5a6400),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffaaba18),
      onTertiaryContainer: Color(0xff404800),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff231a11),
      onSurfaceVariant: Color(0xff554434),
      outline: Color(0xff887361),
      outlineVariant: Color(0xffdbc2ad),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e25),
      inversePrimary: Color(0xffffb870),
      primaryFixed: Color(0xffffdcbe),
      onPrimaryFixed: Color(0xff2c1600),
      primaryFixedDim: Color(0xffffb870),
      onPrimaryFixedVariant: Color(0xff693c00),
      secondaryFixed: Color(0xffffdcbe),
      onSecondaryFixed: Color(0xff2c1600),
      secondaryFixedDim: Color(0xfff6bb81),
      onSecondaryFixedVariant: Color(0xff663d0e),
      tertiaryFixed: Color(0xffdced4e),
      onTertiaryFixed: Color(0xff1a1e00),
      tertiaryFixedDim: Color(0xffc0d033),
      onTertiaryFixedVariant: Color(0xff444b00),
      surfaceDim: Color(0xffe9d7c9),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffdebdc),
      surfaceContainerHigh: Color(0xfff7e5d7),
      surfaceContainerHighest: Color(0xfff1dfd1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff522d00),
      surfaceTint: Color(0xff8b5000),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9f5d00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff522d00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff926331),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff343a00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff687300),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff181008),
      onSurfaceVariant: Color(0xff433324),
      outline: Color(0xff614f3f),
      outlineVariant: Color(0xff7d6958),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e25),
      inversePrimary: Color(0xffffb870),
      primaryFixed: Color(0xff9f5d00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff7d4800),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff926331),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff764b1b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff687300),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff515a00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5c3b6),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfff7e5d7),
      surfaceContainerHigh: Color(0xffecdacc),
      surfaceContainerHighest: Color(0xffe0cec1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff442500),
      surfaceTint: Color(0xff8b5000),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6d3e00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff442500),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff694010),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2a2f00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff464d00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff38291b),
      outlineVariant: Color(0xff574636),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e25),
      inversePrimary: Color(0xffffb870),
      primaryFixed: Color(0xff6d3e00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff4d2a00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff694010),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4d2a00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff464d00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff303600),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6b6a8),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffeee1),
      surfaceContainer: Color(0xfff1dfd1),
      surfaceContainerHigh: Color(0xffe3d1c3),
      surfaceContainerHighest: Color(0xffd5c3b6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffc081),
      surfaceTint: Color(0xffffb870),
      onPrimary: Color(0xff4a2800),
      primaryContainer: Color(0xffff9800),
      onPrimaryContainer: Color(0xff653900),
      secondary: Color(0xfff6bb81),
      onSecondary: Color(0xff4a2800),
      secondaryContainer: Color(0xff663d0e),
      onSecondaryContainer: Color(0xffe3aa71),
      tertiary: Color(0xffc5d638),
      onTertiary: Color(0xff2e3300),
      tertiaryContainer: Color(0xffaaba18),
      onTertiaryContainer: Color(0xff404800),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a120a),
      onSurface: Color(0xfff1dfd1),
      onSurfaceVariant: Color(0xffdbc2ad),
      outline: Color(0xffa38d7a),
      outlineVariant: Color(0xff554434),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfd1),
      inversePrimary: Color(0xff8b5000),
      primaryFixed: Color(0xffffdcbe),
      onPrimaryFixed: Color(0xff2c1600),
      primaryFixedDim: Color(0xffffb870),
      onPrimaryFixedVariant: Color(0xff693c00),
      secondaryFixed: Color(0xffffdcbe),
      onSecondaryFixed: Color(0xff2c1600),
      secondaryFixedDim: Color(0xfff6bb81),
      onSecondaryFixedVariant: Color(0xff663d0e),
      tertiaryFixed: Color(0xffdced4e),
      onTertiaryFixed: Color(0xff1a1e00),
      tertiaryFixedDim: Color(0xffc0d033),
      onTertiaryFixedVariant: Color(0xff444b00),
      surfaceDim: Color(0xff1a120a),
      surfaceBright: Color(0xff42372d),
      surfaceContainerLowest: Color(0xff150d06),
      surfaceContainerLow: Color(0xff231a11),
      surfaceContainer: Color(0xff271e15),
      surfaceContainerHigh: Color(0xff32281f),
      surfaceContainerHighest: Color(0xff3e3329),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd5ae),
      surfaceTint: Color(0xffffb870),
      onPrimary: Color(0xff3b1f00),
      primaryContainer: Color(0xffff9800),
      onPrimaryContainer: Color(0xff3a1f00),
      secondary: Color(0xffffd5ae),
      onSecondary: Color(0xff3b1f00),
      secondaryContainer: Color(0xffbb8651),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd6e748),
      onTertiary: Color(0xff242800),
      tertiaryContainer: Color(0xffaaba18),
      onTertiaryContainer: Color(0xff242800),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a120a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff2d8c2),
      outline: Color(0xffc5ae99),
      outlineVariant: Color(0xffa28c79),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfd1),
      inversePrimary: Color(0xff6b3d00),
      primaryFixed: Color(0xffffdcbe),
      onPrimaryFixed: Color(0xff1e0d00),
      primaryFixedDim: Color(0xffffb870),
      onPrimaryFixedVariant: Color(0xff522d00),
      secondaryFixed: Color(0xffffdcbe),
      onSecondaryFixed: Color(0xff1e0d00),
      secondaryFixedDim: Color(0xfff6bb81),
      onSecondaryFixedVariant: Color(0xff522d00),
      tertiaryFixed: Color(0xffdced4e),
      onTertiaryFixed: Color(0xff101300),
      tertiaryFixedDim: Color(0xffc0d033),
      onTertiaryFixedVariant: Color(0xff343a00),
      surfaceDim: Color(0xff1a120a),
      surfaceBright: Color(0xff4e4238),
      surfaceContainerLowest: Color(0xff0d0602),
      surfaceContainerLow: Color(0xff251c13),
      surfaceContainer: Color(0xff30261d),
      surfaceContainerHigh: Color(0xff3b3127),
      surfaceContainerHighest: Color(0xff473c32),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffeddf),
      surfaceTint: Color(0xffffb870),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffb363),
      onPrimaryContainer: Color(0xff150800),
      secondary: Color(0xffffeddf),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xfff2b77d),
      onSecondaryContainer: Color(0xff150800),
      tertiary: Color(0xffe9fb5b),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbccc2e),
      onTertiaryContainer: Color(0xff0a0c00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1a120a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffeddf),
      outlineVariant: Color(0xffd7bea9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfd1),
      inversePrimary: Color(0xff6b3d00),
      primaryFixed: Color(0xffffdcbe),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb870),
      onPrimaryFixedVariant: Color(0xff1e0d00),
      secondaryFixed: Color(0xffffdcbe),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xfff6bb81),
      onSecondaryFixedVariant: Color(0xff1e0d00),
      tertiaryFixed: Color(0xffdced4e),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc0d033),
      onTertiaryFixedVariant: Color(0xff101300),
      surfaceDim: Color(0xff1a120a),
      surfaceBright: Color(0xff5a4e43),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff271e15),
      surfaceContainer: Color(0xff392e25),
      surfaceContainerHigh: Color(0xff44392f),
      surfaceContainerHighest: Color(0xff50453a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
