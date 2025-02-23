import 'package:azan_reminder/core/constants/exports.dart';

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    chipTheme: const ChipThemeData(
      backgroundColor: AppPallete.backgroundColor,
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      // contentPadding: const EdgeInsets.all(27),
      border: _border(color: Colors.red),
      focusedBorder: _border(color: AppPallete.primaryColor),
      enabledBorder: _border(color: Colors.grey),
      errorBorder: _border(color: Colors.red),
      focusedErrorBorder: _border(color: Colors.red),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPallete.seedColor,
      primary: AppPallete.primaryColor,
    ),
  );
 
  static OutlineInputBorder _border({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
    static TextStyle defaultTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.almarai(
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Colors.black,
    );
  }
}
