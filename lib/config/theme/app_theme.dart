import 'package:flutter/material.dart';

class AppTheme {

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xfff2f2f2),
      scaffoldBackgroundColor: const Color(0xff1a1c1e),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff202329),
        selectedItemColor: Color(0xff0a84ff),
        unselectedItemColor: Color(0xff0a84ff),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
      cardTheme: const CardTheme(
        color: Color(0xff202329),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xfff2f2f2)
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xff1a1c1e),
        centerTitle: true,
      ),
      brightness: Brightness.light,
      fontFamily: 'Nunito'
  );

}