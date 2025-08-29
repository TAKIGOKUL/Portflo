import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00D9FF);
  static const Color secondaryColor = Color(0xFF6C5CE7);
  static const Color accentColor = Color(0xFFFF6B6B);
  static const Color successColor = Color(0xFF00E676);
  static const Color warningColor = Color(0xFFFFAB00);
  static const Color errorColor = Color(0xFFFF3D71);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF2A2A2A);
  static const Color darkBorder = Color(0xFF3A3A3A);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F5);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Noctis Theme Colors
  static const Color noctisBackground = Color(0xFF1B1B1B);
  static const Color noctisSurface = Color(0xFF2D2D2D);
  static const Color noctisCard = Color(0xFF3D3D3D);
  static const Color noctisBorder = Color(0xFF4D4D4D);
  static const Color noctisPrimary = Color(0xFF7B68EE);
  static const Color noctisSecondary = Color(0xFF9370DB);

  // SublimeGit Theme Colors
  static const Color sublimeBackground = Color(0xFF0D1117);
  static const Color sublimeSurface = Color(0xFF161B22);
  static const Color sublimeCard = Color(0xFF21262D);
  static const Color sublimeBorder = Color(0xFF30363D);
  static const Color sublimePrimary = Color(0xFF58A6FF);
  static const Color sublimeSecondary = Color(0xFF79C0FF);

  // Text Colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextTertiary = Color(0xFF808080);

  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF555555);
  static const Color lightTextTertiary = Color(0xFF888888);

  // Noctis Text Colors
  static const Color noctisTextPrimary = Color(0xFFE6E6E6);
  static const Color noctisTextSecondary = Color(0xFFB8B8B8);
  static const Color noctisTextTertiary = Color(0xFF8A8A8A);

  // SublimeGit Text Colors
  static const Color sublimeTextPrimary = Color(0xFFF0F6FC);
  static const Color sublimeTextSecondary = Color(0xFFC9D1D9);
  static const Color sublimeTextTertiary = Color(0xFF8B949E);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [darkBackground, Color(0xFF1A1A2E), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF2A2A2A), Color(0xFF1A1A1A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Noctis Gradients
  static const LinearGradient noctisBackgroundGradient = LinearGradient(
    colors: [noctisBackground, Color(0xFF2D2D2D), Color(0xFF1B1B1B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient noctisCardGradient = LinearGradient(
    colors: [noctisCard, noctisSurface],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // SublimeGit Gradients
  static const LinearGradient sublimeBackgroundGradient = LinearGradient(
    colors: [sublimeBackground, Color(0xFF161B22), Color(0xFF0D1117)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sublimeCardGradient = LinearGradient(
    colors: [sublimeCard, sublimeSurface],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static List<BoxShadow> get cardShadows => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: primaryColor.withValues(alpha: 0.05),
          blurRadius: 40,
          offset: const Offset(0, 20),
        ),
      ];

  static List<BoxShadow> get buttonShadows => [
        BoxShadow(
          color: primaryColor.withValues(alpha: 0.3),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ];

  // Border Radius
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius imageRadius = BorderRadius.all(Radius.circular(20));

  // Text Styles
  static TextStyle get headingLarge => GoogleFonts.spaceGrotesk(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get headingMedium => GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        height: 1.3,
        letterSpacing: -0.3,
      );

  static TextStyle get headingSmall => GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.4,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  static TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  // Theme Data Methods
  static ThemeData getNoctisTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: noctisPrimary,
      scaffoldBackgroundColor: noctisBackground,
      colorScheme: const ColorScheme.dark(
        primary: noctisPrimary,
        secondary: noctisSecondary,
        surface: noctisSurface,
        background: noctisBackground,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: noctisTextPrimary,
        onBackground: noctisTextPrimary,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: noctisTextPrimary),
        titleTextStyle: headingSmall.copyWith(color: noctisTextPrimary),
      ),
              cardTheme: CardThemeData(
          color: noctisCard,
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: cardRadius),
          shadowColor: Colors.black.withValues(alpha: 0.1),
        ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: noctisPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: noctisPrimary.withValues(alpha: 0.3),
          shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
          textStyle: buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: noctisPrimary,
          side: const BorderSide(color: noctisPrimary, width: 2),
          shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
          textStyle: buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: noctisPrimary,
          textStyle: buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: noctisCard,
        border: OutlineInputBorder(
          borderRadius: buttonRadius,
          borderSide: const BorderSide(color: noctisBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: buttonRadius,
          borderSide: const BorderSide(color: noctisBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: buttonRadius,
          borderSide: const BorderSide(color: noctisPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: buttonRadius,
          borderSide: const BorderSide(color: errorColor),
        ),
        labelStyle: bodyMedium.copyWith(color: noctisTextSecondary),
        hintStyle: bodyMedium.copyWith(color: noctisTextTertiary),
      ),
      dividerTheme: const DividerThemeData(
        color: noctisBorder,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(
        color: noctisTextSecondary,
        size: 24,
      ),
    );
  }

  static ThemeData getSublimeGitTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: sublimePrimary,
      scaffoldBackgroundColor: sublimeBackground,
      colorScheme: const ColorScheme.dark(
        primary: sublimePrimary,
        secondary: sublimeSecondary,
        surface: sublimeSurface,
        background: sublimeBackground,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: sublimeTextPrimary,
        onBackground: sublimeTextPrimary,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: sublimeTextPrimary),
        titleTextStyle: headingSmall.copyWith(color: sublimeTextPrimary),
      ),
              cardTheme: CardThemeData(
          color: sublimeCard,
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: cardRadius),
          shadowColor: Colors.black.withValues(alpha: 0.1),
        ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: sublimePrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: sublimePrimary.withValues(alpha: 0.3),
          shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
          textStyle: buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: sublimePrimary,
          side: const BorderSide(color: sublimePrimary, width: 2),
          shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
          textStyle: buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: sublimePrimary,
          textStyle: buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: sublimeCard,
        border: OutlineInputBorder(
          borderRadius: buttonRadius,
          borderSide: const BorderSide(color: sublimeBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: buttonRadius,
          borderSide: const BorderSide(color: sublimeBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: buttonRadius,
          borderSide: const BorderSide(color: sublimePrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: buttonRadius,
          borderSide: const BorderSide(color: errorColor),
        ),
        labelStyle: bodyMedium.copyWith(color: sublimeTextSecondary),
        hintStyle: bodyMedium.copyWith(color: sublimeTextTertiary),
      ),
      dividerTheme: const DividerThemeData(
        color: sublimeBorder,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(
        color: sublimeTextSecondary,
        size: 24,
      ),
    );
  }

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: darkSurface,
          background: darkBackground,
          error: errorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: darkTextPrimary,
          onBackground: darkTextPrimary,
          onError: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: darkTextPrimary),
          titleTextStyle: headingSmall.copyWith(color: darkTextPrimary),
        ),
        cardTheme: CardThemeData(
          color: darkCard,
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: cardRadius),
          shadowColor: Colors.black.withValues(alpha: 0.1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: primaryColor.withValues(alpha: 0.3),
            shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
            textStyle: buttonText,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: const BorderSide(color: primaryColor, width: 2),
            shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
            textStyle: buttonText,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: buttonText,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkCard,
          border: OutlineInputBorder(
            borderRadius: buttonRadius,
            borderSide: const BorderSide(color: darkBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: buttonRadius,
            borderSide: const BorderSide(color: darkBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: buttonRadius,
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: buttonRadius,
            borderSide: const BorderSide(color: errorColor),
          ),
          labelStyle: bodyMedium.copyWith(color: darkTextSecondary),
          hintStyle: bodyMedium.copyWith(color: darkTextTertiary),
        ),
        dividerTheme: const DividerThemeData(
          color: darkBorder,
          thickness: 1,
        ),
        iconTheme: const IconThemeData(
          color: darkTextSecondary,
          size: 24,
        ),
      );

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: lightBackground,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: lightSurface,
          background: lightBackground,
          error: errorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: lightTextPrimary,
          onBackground: lightTextPrimary,
          onError: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: lightTextPrimary),
          titleTextStyle: headingSmall.copyWith(color: lightTextPrimary),
        ),
        cardTheme: CardThemeData(
          color: lightCard,
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: cardRadius),
          shadowColor: Colors.black.withValues(alpha: 0.1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: primaryColor.withValues(alpha: 0.3),
            shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
            textStyle: buttonText,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: const BorderSide(color: primaryColor, width: 2),
            shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
            textStyle: buttonText,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: buttonText,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightCard,
          border: OutlineInputBorder(
            borderRadius: buttonRadius,
            borderSide: const BorderSide(color: lightBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: buttonRadius,
            borderSide: const BorderSide(color: lightBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: buttonRadius,
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: buttonRadius,
            borderSide: const BorderSide(color: errorColor),
          ),
          labelStyle: bodyMedium.copyWith(color: lightTextSecondary),
          hintStyle: bodyMedium.copyWith(color: lightTextTertiary),
        ),
        dividerTheme: const DividerThemeData(
          color: lightBorder,
          thickness: 1,
        ),
        iconTheme: const IconThemeData(
          color: lightTextSecondary,
          size: 24,
        ),
      );
}
