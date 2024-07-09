import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      background: Colors.white,
      onBackground: Colors.black87,
      brightness: Brightness.light,
      primary: Color(0xff4f5b92),
      surfaceTint: Color(0xff4f5b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdde1ff),
      onPrimaryContainer: Color(0xff07164b),
      secondary: Color(0xff4f5b92),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdde1ff),
      onSecondaryContainer: Color(0xff07164b),
      tertiary: Color(0xff4f5b92),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdde1ff),
      onTertiaryContainer: Color(0xff07164b),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff1b1b21),
      onSurfaceVariant: Color(0xff45464f),
      outline: Color(0xff4f5b92),
      outlineVariant: Color(0xffc6c5d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffb8c4ff),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      background: Colors.white,
      onBackground: Colors.black87,
      brightness: Brightness.light,
      primary: Color(0xff333f74),
      surfaceTint: Color(0xff4f5b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6572aa),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff333f74),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6572aa),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff333f74),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6572aa),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff1b1b21),
      onSurfaceVariant: Color(0xff41424b),
      outline: Color(0xff5e5e67),
      outlineVariant: Color(0xff7a7a83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffb8c4ff),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      background: Colors.white,
      onBackground: Colors.black87,
      brightness: Brightness.light,
      primary: Color(0xff0f1d52),
      surfaceTint: Color(0xff4f5b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff333f74),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0f1d52),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff333f74),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0f1d52),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff333f74),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff22232b),
      outline: Color(0xff41424b),
      outlineVariant: Color(0xff41424b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffe9ebff),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      background: Color.fromARGB(255, 26, 26, 26),
      onBackground: Colors.white70,
      brightness: Brightness.dark,
      primary: Color(0xffb8c4ff),
      surfaceTint: Color(0xffb8c4ff),
      onPrimary: Color(0xff1f2c61),
      primaryContainer: Color(0xff374379),
      onPrimaryContainer: Color(0xffdde1ff),
      secondary: Color(0xffb8c4ff),
      onSecondary: Color(0xff1f2c61),
      secondaryContainer: Color(0xff374379),
      onSecondaryContainer: Color(0xffdde1ff),
      tertiary: Color(0xffb8c4ff),
      onTertiary: Color(0xff1f2c61),
      tertiaryContainer: Color(0xff374379),
      onTertiaryContainer: Color(0xffdde1ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color.fromARGB(255, 18, 19, 24),
      onSurface: Color(0xffe3e1e9),
      onSurfaceVariant: Color(0xffc6c5d0),
      outline: Color(0xff90909a),
      outlineVariant: Color(0xff45464f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e1e9),
      inversePrimary: Color(0xff4f5b92),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      background: Colors.black,
      onBackground: Colors.white70,
      brightness: Brightness.dark,
      primary: Color(0xffbdc8ff),
      surfaceTint: Color(0xffb8c4ff),
      onPrimary: Color(0xff011046),
      primaryContainer: Color(0xff818ec8),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbdc8ff),
      onSecondary: Color(0xff011046),
      secondaryContainer: Color(0xff818ec8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbdc8ff),
      onTertiary: Color(0xff011046),
      tertiaryContainer: Color(0xff818ec8),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121318),
      onSurface: Color(0xfffcfaff),
      onSurfaceVariant: Color(0xffcacad4),
      outline: Color(0xffa2a2ac),
      outlineVariant: Color(0xff82828c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e1e9),
      inversePrimary: Color(0xff38457a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      background: Colors.black87,
      onBackground: Colors.white70,
      brightness: Brightness.dark,
      primary: Color(0xfffcfaff),
      surfaceTint: Color(0xffb8c4ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffbdc8ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffcfaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbdc8ff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffcfaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbdc8ff),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffcfaff),
      outline: Color(0xffcacad4),
      outlineVariant: Color(0xffcacad4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e1e9),
      inversePrimary: Color(0xff18265a),
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
