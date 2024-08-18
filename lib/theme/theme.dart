import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

//#region =============== INDIGO ==============================================
  static ColorScheme indigoClaro() {
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

  ThemeData lightIndigo() {
    return theme(indigoClaro());
  }

  static ColorScheme indigoEscuro() {
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

  ThemeData darkIndigo() {
    return theme(indigoEscuro());
  }

//#endregion ============ END INDIGO ==========================================

//#region =============== VERDE ===============================================
  static ColorScheme verdeClaro() {
    return const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white,
      onBackground: Colors.black87,
      primary: Color(0xff406835),
      surfaceTint: Color(0xff406835),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc1efaf),
      onPrimaryContainer: Color(0xff012200),
      secondary: Color(0xff406835),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc1efaf),
      onSecondaryContainer: Color(0xff012200),
      tertiary: Color(0xff406835),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc1efaf),
      onTertiaryContainer: Color(0xff012200),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffa5d395),
    );
  }

  ThemeData lightVerde() {
    return theme(verdeClaro());
  }

  static ColorScheme verdeEscuro() {
    return const ColorScheme(
      brightness: Brightness.dark,
      background: Color.fromARGB(255, 26, 26, 26),
      onBackground: Colors.white70,
      primary: Color(0xffa5d395),
      surfaceTint: Color(0xffa5d395),
      onPrimary: Color(0xff11380b),
      primaryContainer: Color(0xff295020),
      onPrimaryContainer: Color(0xffc1efaf),
      secondary: Color(0xffa5d395),
      onSecondary: Color(0xff11380b),
      secondaryContainer: Color(0xff295020),
      onSecondaryContainer: Color(0xffc1efaf),
      tertiary: Color(0xffa5d395),
      onTertiary: Color(0xff11380b),
      tertiaryContainer: Color(0xff295020),
      onTertiaryContainer: Color(0xffc1efaf),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff406835),
    );
  }

  ThemeData darkVerde() {
    return theme(verdeEscuro());
  }
//#endregion ============ END VERDE ===========================================

//#region =============== AMARELO ============================================

  static ColorScheme amareloClaro() {
    return const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white,
      onBackground: Colors.black87,
      primary: Color.fromARGB(255, 209, 157, 0),
      surfaceTint: Color(0xff735c0c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffe08a),
      onPrimaryContainer: Color(0xff241a00),
      secondary: Color(0xff735c0c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffe08a),
      onSecondaryContainer: Color(0xff241a00),
      tertiary: Color(0xff735c0c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffe08a),
      onTertiaryContainer: Color(0xff241a00),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffe3c46d),
    );
  }

  ThemeData lightAmarelo() {
    return theme(amareloClaro());
  }

  static ColorScheme amareloEscuro() {
    return const ColorScheme(
      brightness: Brightness.dark,
      background: Color.fromARGB(255, 26, 26, 26),
      onBackground: Colors.white70,
      primary: Color(0xffe3c46d),
      surfaceTint: Color(0xffe3c46d),
      onPrimary: Color(0xff3d2f00),
      primaryContainer: Color(0xff584400),
      onPrimaryContainer: Color(0xffffe08a),
      secondary: Color(0xffe3c46d),
      onSecondary: Color(0xff3d2f00),
      secondaryContainer: Color(0xff584400),
      onSecondaryContainer: Color(0xffffe08a),
      tertiary: Color(0xffe3c46d),
      onTertiary: Color(0xff3d2f00),
      tertiaryContainer: Color(0xff584400),
      onTertiaryContainer: Color(0xffffe08a),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff735c0c),
    );
  }

  ThemeData darkAmarelo() {
    return theme(amareloEscuro());
  }

//#endregion ============ END AMARELO ========================================

//#region =============== ROSA =============================================
  static ColorScheme rosaClaro() {
    return const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white,
      onBackground: Colors.black87,
      primary: Color.fromARGB(255, 166, 0, 91),
      surfaceTint: Color(0xff874b6c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffd8e9),
      onPrimaryContainer: Color(0xff380726),
      secondary: Color(0xff874b6c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffd8e9),
      onSecondaryContainer: Color(0xff380726),
      tertiary: Color(0xff874b6c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd8e9),
      onTertiaryContainer: Color(0xff380726),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xfffcb0d6),
    );
  }

  ThemeData lightRosa() {
    return theme(rosaClaro());
  }

  static ColorScheme rosaEscuro() {
    return const ColorScheme(
      brightness: Brightness.dark,
      background: Color.fromARGB(255, 26, 26, 26),
      onBackground: Colors.white70,
      primary: Color.fromARGB(255, 208, 0, 104),
      surfaceTint: Color(0xfffcb0d6),
      onPrimary: Color(0xff521d3c),
      primaryContainer: Color.fromARGB(255, 92, 22, 61),
      onPrimaryContainer: Color(0xffffd8e9),
      secondary: Color(0xfffcb0d6),
      onSecondary: Color(0xff521d3c),
      secondaryContainer: Color(0xff6c3453),
      onSecondaryContainer: Color(0xffffd8e9),
      tertiary: Color(0xfffcb0d6),
      onTertiary: Color(0xff521d3c),
      tertiaryContainer: Color(0xff6c3453),
      onTertiaryContainer: Color(0xffffd8e9),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff874b6c),
    );
  }

  ThemeData darkRosa() {
    return theme(rosaEscuro());
  }

//#endregion ============ END ROSA =========================================
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
