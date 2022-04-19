import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    primaryColorLight: kPrimaryColorLight,
    primaryColorDark: kPrimaryColorDark,
    secondaryHeaderColor: kblue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kblue, foregroundColor: kLight),
    indicatorColor: kPrimaryColor,
    chipTheme: ChipThemeData(backgroundColor: kLightGrey),
    scaffoldBackgroundColor: kLight,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: kPrimaryColor,
      elevation: kElevation,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kWhite,
      foregroundColor: kDarkGrey,
      iconTheme: const IconThemeData(
        color: kblue,
      ),
    ),
    iconTheme: const IconThemeData(color: kblue),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorLightTheme),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: const IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    primaryColorLight: darkPrimaryColorLight,
    primaryColorDark: kPrimaryColorDark,
    secondaryHeaderColor: kPrimaryColorBright,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: kLightGrey,
      foregroundColor: kDarkGrey,
      iconTheme: const IconThemeData(
        color: kPrimaryColor,
      ),
    ),
    iconTheme: const IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: const IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}
