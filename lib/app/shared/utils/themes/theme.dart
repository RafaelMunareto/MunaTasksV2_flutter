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
    primaryColor: darkPrimaryColor,
    primaryColorLight: darkPrimaryColorLight,
    primaryColorDark: darkPrimaryColorDark,
    secondaryHeaderColor: darkblue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkblue, foregroundColor: darkLight),
    indicatorColor: darkPrimaryColor,
    chipTheme: ChipThemeData(backgroundColor: darkLightGrey),
    scaffoldBackgroundColor: darkLight,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkPrimaryColor,
      elevation: kElevation,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kDardBlueGrey,
      iconTheme: const IconThemeData(
        color: kblue,
      ),
    ),
    iconTheme: const IconThemeData(color: kblue),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: darkWhite),
    colorScheme: ColorScheme.light(
      primary: darkPrimaryColor,
      secondary: klightGrey,
      error: darkErrorColor,
    ),
    dialogBackgroundColor: kligthBlueGrey,
    inputDecorationTheme: InputDecorationTheme(iconColor: klightGrey),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkDarkGrey,
      selectedItemColor: darkContentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: darkContentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: const IconThemeData(color: darkPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}
