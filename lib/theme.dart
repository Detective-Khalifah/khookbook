import "package:flutter/material.dart";
import "package:khookbook/constants/colors.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: kM3LightPrimary,
      surfaceTint: kM3LightPrimary, // surfaceTint often matches primary
      onPrimary: kM3LightOnPrimary,
      primaryContainer: kM3LightPrimaryContainer,
      onPrimaryContainer: kM3LightOnPrimaryContainer,
      secondary: kM3LightSecondary,
      onSecondary: kM3LightOnSecondary,
      secondaryContainer: kM3LightSecondaryContainer,
      onSecondaryContainer: kM3LightOnSecondaryContainer,
      tertiary: kM3LightTertiary,
      onTertiary: kM3LightOnTertiary,
      tertiaryContainer: kM3LightTertiaryContainer,
      onTertiaryContainer: kM3LightOnTertiaryContainer,
      error: kM3LightError,
      onError: kM3LightOnError,
      errorContainer: kM3LightErrorContainer,
      onErrorContainer: kM3LightOnErrorContainer,
      surface: kM3LightSurface, // Typically used as background
      onSurface: kM3LightOnSurface, // Text/icon color on background
      surfaceVariant:
          kM3LightSurfaceContainer, // M3 uses surfaceContainer for this role now
      onSurfaceVariant: kM3LightOnSurfaceVariant,
      outline: kM3LightOutline,
      outlineVariant: kM3LightOutlineVariant,
      shadow: kM3LightShadow,
      scrim: kM3LightScrim,
      inverseSurface: kM3LightInverseSurface,
      onInverseSurface: kM3LightOnInverseSurface,
      inversePrimary: kM3LightInversePrimary,
      primaryFixed: kM3LightPrimaryFixed,
      onPrimaryFixed: kM3LightOnPrimaryFixed,
      primaryFixedDim: kM3LightPrimaryFixedDim,
      onPrimaryFixedVariant: kM3LightOnPrimaryFixedVariant,
      secondaryFixed: kM3LightSecondaryFixed,
      onSecondaryFixed: kM3LightOnSecondaryFixed,
      secondaryFixedDim: kM3LightSecondaryFixedDim,
      onSecondaryFixedVariant: kM3LightOnSecondaryFixedVariant,
      tertiaryFixed: kM3LightTertiaryFixed,
      onTertiaryFixed: kM3LightOnTertiaryFixed,
      tertiaryFixedDim: kM3LightTertiaryFixedDim,
      onTertiaryFixedVariant: kM3LightOnTertiaryFixedVariant,
      surfaceDim: kM3LightSurfaceDim,
      surfaceBright: kM3LightSurfaceBright,
      surfaceContainerLowest: kM3LightSurfaceContainerLowest,
      surfaceContainerLow: kM3LightSurfaceContainerLow,
      surfaceContainer: kM3LightSurfaceContainer,
      surfaceContainerHigh: kM3LightSurfaceContainerHigh,
      surfaceContainerHighest: kM3LightSurfaceContainerHighest,
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
      primary: kLightHighPrimary,
      surfaceTint: kLightHighPrimary,
      onPrimary: Colors.white,
      primaryContainer: kPrimaryOrange,
      onPrimaryContainer: Colors.white,
      secondary: kLightHighSecondary,
      onSecondary: Colors.white,
      secondaryContainer: kSecondaryBrown,
      onSecondaryContainer: Colors.white,
      tertiary: kAccentYellow,
      onTertiary: kDeepBrown,
      tertiaryContainer: Color(0xFFFFECB3),
      onTertiaryContainer: kDeepBrown,
      error: kLightHighError,
      onError: Colors.white,
      errorContainer: Color(0xFFFFCAC8),
      onErrorContainer: Color(0xFF410002),
      surface: kLightHighSurface,
      onSurface: kDeepBrown,
      surfaceVariant: kNeutralCream,
      // surfaceContainerHighest: kNeutralCream,
      onSurfaceVariant: kDeepBrown,
      outline: kM3LightOutline,
      outlineVariant: kM3LightOutlineVariant,
      shadow: kM3LightShadow,
      scrim: kM3LightScrim,
      inverseSurface: kM3LightInverseSurface,
      onInverseSurface: kM3LightOnInverseSurface,
      inversePrimary: kM3LightInversePrimary,
      primaryFixed: kM3LightPrimaryFixed,
      onPrimaryFixed: kM3LightOnPrimaryFixed,
      primaryFixedDim: kM3LightPrimaryFixedDim,
      onPrimaryFixedVariant: kM3LightOnPrimaryFixedVariant,
      secondaryFixed: kM3LightSecondaryFixed,
      onSecondaryFixed: kM3LightOnSecondaryFixed,
      secondaryFixedDim: kM3LightSecondaryFixedDim,
      onSecondaryFixedVariant: kM3LightOnSecondaryFixedVariant,
      tertiaryFixed: kM3LightTertiaryFixed,
      onTertiaryFixed: kM3LightOnTertiaryFixed,
      tertiaryFixedDim: kM3LightTertiaryFixedDim,
      onTertiaryFixedVariant: kM3LightOnTertiaryFixedVariant,
      surfaceDim: kM3LightSurfaceDim,
      surfaceBright: kM3LightSurfaceBright,
      surfaceContainerLowest: kM3LightSurfaceContainerLowest,
      surfaceContainerLow: kM3LightSurfaceContainerLow,
      surfaceContainer: kM3LightSurfaceContainer,
      surfaceContainerHigh: kM3LightSurfaceContainerHigh,
      surfaceContainerHighest: kM3LightSurfaceContainerHighest,
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: kM3DarkPrimary,
      surfaceTint:
          kM3DarkPrimaryFixedDim, // surfaceTint often matches primaryFixedDim in dark
      onPrimary: kM3DarkOnPrimary,
      primaryContainer: kM3DarkPrimaryContainer,
      onPrimaryContainer: kM3DarkOnPrimaryContainer,
      secondary: kM3DarkSecondary,
      onSecondary: kM3DarkOnSecondary,
      secondaryContainer: kM3DarkSecondaryContainer,
      onSecondaryContainer: kM3DarkOnSecondaryContainer,
      tertiary: kM3DarkTertiary,
      onTertiary: kM3DarkOnTertiary,
      tertiaryContainer: kM3DarkTertiaryContainer,
      onTertiaryContainer: kM3DarkOnTertiaryContainer,
      error: kM3DarkError,
      onError: kM3DarkOnError,
      errorContainer: kM3DarkErrorContainer,
      onErrorContainer: kM3DarkOnErrorContainer,
      surface: kM3DarkSurface, // Typically used as background
      onSurface: kM3DarkOnSurface, // Text/icon color on background
      surfaceVariant:
          kM3DarkSurfaceContainer, // M3 uses surfaceContainer for this role now
      onSurfaceVariant: kM3DarkOnSurfaceVariant,
      outline: kM3DarkOutline,
      outlineVariant: kM3DarkOutlineVariant,
      shadow: kM3DarkShadow,
      scrim: kM3DarkScrim,
      inverseSurface: kM3DarkInverseSurface,
      onInverseSurface: kM3DarkOnInverseSurface,
      inversePrimary: kM3DarkInversePrimary,
      primaryFixed: kM3DarkPrimaryFixed,
      onPrimaryFixed: kM3DarkOnPrimaryFixed,
      primaryFixedDim: kM3DarkPrimaryFixedDim,
      onPrimaryFixedVariant: kM3DarkOnPrimaryFixedVariant,
      secondaryFixed: kM3DarkSecondaryFixed,
      onSecondaryFixed: kM3DarkOnSecondaryFixed,
      secondaryFixedDim: kM3DarkSecondaryFixedDim,
      onSecondaryFixedVariant: kM3DarkOnSecondaryFixedVariant,
      tertiaryFixed: kM3DarkTertiaryFixed,
      onTertiaryFixed: kM3DarkOnTertiaryFixed,
      tertiaryFixedDim: kM3DarkTertiaryFixedDim,
      onTertiaryFixedVariant: kM3DarkOnTertiaryFixedVariant,
      surfaceDim: kM3DarkSurfaceDim,
      surfaceBright: kM3DarkSurfaceBright,
      surfaceContainerLowest: kM3DarkSurfaceContainerLowest,
      surfaceContainerLow: kM3DarkSurfaceContainerLow,
      surfaceContainer: kM3DarkSurfaceContainer,
      surfaceContainerHigh: kM3DarkSurfaceContainerHigh,
      surfaceContainerHighest: kM3DarkSurfaceContainerHighest,
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
      bodyColor: colorScheme.brightness == Brightness.dark
          ? Colors.white
          : kDeepBrown,
      displayColor: colorScheme.brightness == Brightness.dark
          ? Colors.white
          : kDeepBrown,
    ),
    appBarTheme: (colorScheme.brightness == Brightness.light)
        ? AppBarTheme(
            color: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            surfaceTintColor: colorScheme.surfaceTint,
            titleTextStyle: textTheme.titleLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          )
        : null,
    scaffoldBackgroundColor: colorScheme.brightness == Brightness.dark
        ? kDarkMedSurface
        : kSecondaryBrown,
    cardTheme: CardThemeData(
      color: colorScheme.brightness == Brightness.dark
          ? kDarkMedSurface
          : kLightHighSurface,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainer,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) {
          if (states.contains(MaterialState.selected)) {
            return textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold);
          }
          return textTheme.bodyMedium;
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surface;
        }),
      ),
    ),
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
