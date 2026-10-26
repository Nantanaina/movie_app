import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const screenBackground = Color(0xFF111111);
const searchBarBackground = Color(0xFF1E1E1E);
const primaryButton = Color(0xFFD9D9D9);
const posterBorder = Color(0xFFB5A9A9);
const buttonGrey = Color(0xFF504F4F);

var roboto = GoogleFonts.roboto();

final largeTitle = GoogleFonts.roboto(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var heading1 = roboto.copyWith(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var heading2 = roboto.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var body1Regular = roboto.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body1Bold = roboto.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var body2Regular = roboto.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body2Bold = roboto.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var caption = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body3Regular = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body3Bold = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var verySmallText = roboto.copyWith(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

ThemeData createTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2196F3),// Base blue color
      primary: const Color(0xFF2196F3),// Primary color (can be same as seed)
      onPrimary: Colors.white,// Text/icon color on primary background
      secondary: const Color(0xFF90CAF9),// Secondary color (lighter blue)
      onSecondary: Colors.black,// Background color (very light blue)
      surfaceContainerHighest: Colors.black,// Text/icon color on background
      surface: const Color(0xFF111111),// Surface color (cards, menus, etc.)
      onSurface: Colors.white,// Text/icon color on surface
      error: const Color(0xFFB00020),// Error color (red)
      onError: Colors.white,// Text/icon color on error background
      brightness: Brightness.dark, // Overall brightness(light or dark)
    ),

    textTheme: Typography.material2021().englishLike.copyWith(
      headlineLarge: heading1,
      headlineMedium: heading2,
      headlineSmall: body2Regular,
      titleLarge: largeTitle,
      titleMedium: heading2,
      titleSmall: body2Bold,
      bodyLarge: body1Regular,
      bodyMedium: body2Regular,
      bodySmall: body3Regular,
      labelLarge: body1Bold,
      labelMedium: body2Bold,
      labelSmall: caption,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF111111), // App bar background color
      foregroundColor: Colors.white, // Text/icon color on app bar
    ),
    
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: searchBarBackground,
        labelTextStyle:
            WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          // If the item is selected, use primary color; otherwise, use your desired unselected color
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: Colors.white);
          }
          return const TextStyle(color: posterBorder); // Unselected color
        }),
        iconTheme: WidgetStateProperty.all<IconThemeData>(
            const IconThemeData(color: Colors.white)),
        indicatorColor: posterBorder),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: searchBarBackground,// Bottom nav background color
      selectedItemColor: Colors.white,// Selected item color
      unselectedLabelStyle: TextStyle(color: Colors.white),
      showUnselectedLabels: true,
      unselectedItemColor: posterBorder, // Unselected item color
    ),
  );
}
