import 'package:flutter/material.dart';

// Material 3 Theme Colors

// Common Colors (used if a hex value is identical across roles)
const Color kM3ColorWhite = Color(0xFFFFFFFF);
const Color kM3ColorBlack = Color(0xFF000000);

// Light Scheme Colors
const Color kM3LightPrimary = Color(0xFF8B5000);
const Color kM3LightOnPrimary = Color(0xFFFFFFFF);
const Color kM3LightPrimaryContainer = Color(0xFFFF9800);
const Color kM3LightOnPrimaryContainer = Color(0xFF653900);
const Color kM3LightSecondary = Color(0xFF815524);
const Color kM3LightOnSecondary = Color(0xFFFFFFFF);
const Color kM3LightSecondaryContainer = Color(0xFFFFC389);
const Color kM3LightOnSecondaryContainer = Color(0xFF7A4E1E);
const Color kM3LightTertiary = Color(0xFF5A6400);
const Color kM3LightOnTertiary = Color(0xFFFFFFFF);
const Color kM3LightTertiaryContainer = Color(0xFFAABA18);
const Color kM3LightOnTertiaryContainer = Color(0xFF404800);
const Color kM3LightError = Color(0xFFBA1A1A);
const Color kM3LightOnError = Color(0xFFFFFFFF);
const Color kM3LightErrorContainer = Color(0xFFFFDAD6);
const Color kM3LightOnErrorContainer = Color(0xFF93000A);
const Color kM3LightBackground = Color(0xFFFFF8F5);
const Color kM3LightOnBackground = Color(0xFF231A11);
const Color kM3LightSurface = Color(0xFFFFF8F5);
const Color kM3LightOnSurface = Color(0xFF231A11);
const Color kM3LightSurfaceVariant = Color(
  0xFFFDEBDC,
); // Corresponds to M3's surfaceContainer in older versions
const Color kM3LightOnSurfaceVariant = Color(0xFF554434);
const Color kM3LightOutline = Color(0xFF887361);
const Color kM3LightOutlineVariant = Color(0xFFDBC2AD);
const Color kM3LightShadow = Color(0xFF000000);
const Color kM3LightScrim = Color(0xFF000000);
const Color kM3LightInverseSurface = Color(0xFF392E25);
const Color kM3LightOnInverseSurface = Color(
  0xFFF1DFD1,
); // Typically from darkScheme.onSurface
const Color kM3LightInversePrimary = Color(0xFFFFB870);
const Color kM3LightPrimaryFixed = Color(0xFFFFDCBE);
const Color kM3LightOnPrimaryFixed = Color(0xFF2C1600);
const Color kM3LightPrimaryFixedDim = Color(0xFFFFB870);
const Color kM3LightOnPrimaryFixedVariant = Color(0xFF693C00);
const Color kM3LightSecondaryFixed = Color(0xFFFFDCBE);
const Color kM3LightOnSecondaryFixed = Color(0xFF2C1600);
const Color kM3LightSecondaryFixedDim = Color(0xFFF6BB81);
const Color kM3LightOnSecondaryFixedVariant = Color(0xFF663D0E);
const Color kM3LightTertiaryFixed = Color(0xFFDCED4E);
const Color kM3LightOnTertiaryFixed = Color(0xFF1A1E00);
const Color kM3LightTertiaryFixedDim = Color(0xFFC0D033);
const Color kM3LightOnTertiaryFixedVariant = Color(0xFF444B00);
const Color kM3LightSurfaceDim = Color(0xFFE9D7C9);
const Color kM3LightSurfaceBright = Color(0xFFFFF8F5);
const Color kM3LightSurfaceContainerLowest = Color(0xFFFFFFFF);
const Color kM3LightSurfaceContainerLow = Color(0xFFFFF1E7);
const Color kM3LightSurfaceContainer = Color(0xFFFDEBDC);
const Color kM3LightSurfaceContainerHigh = Color(0xFFF7E5D7);
const Color kM3LightSurfaceContainerHighest = Color(0xFFF1DFD1);

// Dark Scheme Colors
const Color kM3DarkPrimary = Color(0xFFFFC081);
const Color kM3DarkOnPrimary = Color(0xFF4A2800);
const Color kM3DarkPrimaryContainer = Color(0xFFFF9800);
const Color kM3DarkOnPrimaryContainer = Color(0xFF653900);
const Color kM3DarkSecondary = Color(0xFFF6BB81);
const Color kM3DarkOnSecondary = Color(0xFF4A2800);
const Color kM3DarkSecondaryContainer = Color(0xFF663D0E);
const Color kM3DarkOnSecondaryContainer = Color(0xFFE3AA71);
const Color kM3DarkTertiary = Color(0xFFC5D638);
const Color kM3DarkOnTertiary = Color(0xFF2E3300);
const Color kM3DarkTertiaryContainer = Color(0xFFAABA18);
const Color kM3DarkOnTertiaryContainer = Color(0xFF404800);
const Color kM3DarkError = Color(0xFFFFB4AB);
const Color kM3DarkOnError = Color(0xFF690005);
const Color kM3DarkErrorContainer = Color(0xFF93000A);
const Color kM3DarkOnErrorContainer = Color(0xFFFFDAD6);
const Color kM3DarkBackground = Color(0xFF1A120A);
const Color kM3DarkOnBackground = Color(0xFFF1DFD1);
const Color kM3DarkSurface = Color(0xFF1A120A);
const Color kM3DarkOnSurface = Color(0xFFF1DFD1);
const Color kM3DarkSurfaceVariant = Color(
  0xFF271E15,
); // Corresponds to M3's surfaceContainer in older versions
const Color kM3DarkOnSurfaceVariant = Color(0xFFDBC2AD);
const Color kM3DarkOutline = Color(0xFFA38D7A);
const Color kM3DarkOutlineVariant = Color(0xFF554434);
const Color kM3DarkShadow = Color(0xFF000000);
const Color kM3DarkScrim = Color(0xFF000000);
const Color kM3DarkInverseSurface = Color(0xFFF1DFD1);
const Color kM3DarkOnInverseSurface = Color(
  0xFF231A11,
); // Typically from lightScheme.onSurface
const Color kM3DarkInversePrimary = Color(0xFF8B5000);
const Color kM3DarkPrimaryFixed = Color(0xFFFFDCBE);
const Color kM3DarkOnPrimaryFixed = Color(0xFF2C1600);
const Color kM3DarkPrimaryFixedDim = Color(0xFFFFB870);
const Color kM3DarkOnPrimaryFixedVariant = Color(0xFF693C00);
const Color kM3DarkSecondaryFixed = Color(0xFFFFDCBE);
const Color kM3DarkOnSecondaryFixed = Color(0xFF2C1600);
const Color kM3DarkSecondaryFixedDim = Color(0xFFF6BB81);
const Color kM3DarkOnSecondaryFixedVariant = Color(0xFF663D0E);
const Color kM3DarkTertiaryFixed = Color(0xFFDCED4E);
const Color kM3DarkOnTertiaryFixed = Color(0xFF1A1E00);
const Color kM3DarkTertiaryFixedDim = Color(0xFFC0D033);
const Color kM3DarkOnTertiaryFixedVariant = Color(0xFF444B00);
const Color kM3DarkSurfaceDim = Color(0xFF1A120A);
const Color kM3DarkSurfaceBright = Color(0xFF42372D);
const Color kM3DarkSurfaceContainerLowest = Color(0xFF150D06);
const Color kM3DarkSurfaceContainerLow = Color(0xFF231A11);
const Color kM3DarkSurfaceContainer = Color(0xFF271E15);
const Color kM3DarkSurfaceContainerHigh = Color(0xFF32281F);
const Color kM3DarkSurfaceContainerHighest = Color(0xFF3E3329);

// Brand Colors
const Color kPrimaryOrange = Color(0xFFFF6B00); // Vibrant orange
const Color kLightOrange = Color(0xFFFFAB40); // Light orange
const Color kDarkOrange = Color(0xFFFF9800); // Darker orange
const Color kSecondaryBrown = Color(0xFF8B4513); // Saddle brown
const Color kAccentYellow = Color(0xFFFFB800); // Golden yellow
const Color kNeutralCream = Color(0xFFFFF3E0); // Warm cream
const Color kDeepBrown = Color(0xFF3E2723); // Dark brown

// Light Theme High Contrast
const Color kLightHighPrimary = Color(0xFFE65100); // Deep orange
const Color kLightHighSecondary = Color(0xFF6D4C41); // Deep brown
const Color kLightHighSurface = Color(0xFFFBE9E7); // Light peach
const Color kLightHighError = Color(0xFFD50000); // Bright red

// Light Theme Medium Contrast
const Color kLightMedPrimary = Color(0xFFF57C00); // Medium orange
const Color kLightMedSecondary = Color(0xFF795548); // Medium brown
const Color kLightMedSurface = Color(0xFFFFF3E0); // Warm cream
const Color kLightMedError = Color(0xFFFF5722); // Deep orange red

// Dark Theme Medium Contrast
const Color kDarkMedPrimary = Color(0xFFFFB74D); // Light orange
const Color kDarkMedSecondary = Color(0xFFBCAAA4); // Light brown
const Color kDarkMedSurface = Color(0xFF3E2723); // Dark brown
const Color kDarkMedError = Color(0xFFFF8A65); // Light orange red

// Dark Theme High Contrast
const Color kDarkHighPrimary = Color(0xFFFFCC80); // Very light orange
const Color kDarkHighSecondary = Color(0xFFD7CCC8); // Very light brown
const Color kDarkHighSurface = Color(0xFF1B0000); // Almost black
const Color kDarkHighError = Color(0xFFFFAB91); // Very light orange red
// Note: The above colors are defined to match the Material 3 theme
// and can be used in the app's theme or widgets as needed.

// User-defined colors (from previous context, if still needed outside of M3 theme)
// You can add the specific brand colors here if they are not part of the M3 generated schemes
// For example:
// const Color kUserPrimaryOrange = Color(0xFFFA831D);
// const Color kUserGridViewBackground = Color(0xFFFFE5C6);
// const Color kUserMealPageBackground = Color(0xFFFFD180); // Colors.orangeAccent.shade100

// Text colors (if specific ones are needed beyond onSurface, onPrimary etc.)
// const Color kUserDarkTextColor = Colors.black87;
// const Color kUserErrorTextColor = Colors.red;

// Note: The M3 schemes above are comprehensive.
// If you decide to use the custom brand colors (like kUserPrimaryOrange)
// as the primary colors in the theme, you would modify the kM3LightPrimary,
// kM3DarkPrimary, etc., assignments in theme.dart directly or map them
// to the custom constants.
// This file, as generated, strictly reflects the colors from the provided theme.dart.

// Specific shade from meal_page.dart (Colors.orangeAccent.shade100)
const Color kMealPageBackgroundOrangeAccentShade100 = Color(0xFFFFD180);

// The previous primary color, if you want to keep it defined
const Color kLegacyPrimaryOrange = Color(0xFFFA831D);
const Color kLegacyAccentOrange = Color(0xB0FA831D);
const Color kLegacyGridViewBackground = Color(0xFFFFE5C6);

// Text colors for specific overrides if needed
const Color kExplicitDarkText = Color(0xFF000000); // Example: Colors.black
const Color kExplicitDarkText87 = Color(0xDE000000); // Example: Colors.black87
const Color kExplicitErrorText = Color(
  0xFFD32F2F,
); // Example: Colors.red.shade700

// The following are colors from the old `constants/colors.dart`
// that were not directly part of the Material Theme Builder output.
// You can decide if you still need them or if the M3 colors cover their use cases.

// Primary brand color (Orange) - This was the custom primary
// const Color kPrimaryColor = Color(0xFFFA831D); // Now kLegacyPrimaryOrange

// Accent color (Semi-transparent Orange) - This was the custom accent
// const Color kAccentColor = Color(0xB0FA831D); // Now kLegacyAccentOrange

// Background color for grid views or specific sections (Light Peach/Cream) - the custom grid bg
// const Color kGridViewBackgroundColor = Color(0xFFFFE5C6); // Now kLegacyGridViewBackground

// Specific background color used in MealPage (Light Orange Accent)
const Color kMealPageBackgroundColorBase =
    Colors.orangeAccent; // Using the base swatch
// const Color kMealPageBackgroundColorShade = Color(0xFFFFD180); // Now kMealPageBackgroundOrangeAccentShade100

// Text colors for contrast on light backgrounds
const Color kStandardDarkTextColor = Colors.black87; // Now kExplicitDarkText87
const Color kStandardErrorTextColor =
    Colors.red; // Now kExplicitErrorText (or a shade)
