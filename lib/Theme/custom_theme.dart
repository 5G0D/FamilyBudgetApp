import 'package:flutter/material.dart';

import '../date_picker_controller.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue,
    );
  }

  static get appBarColor => Color(DatePickerController.date ==
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
      ? 0xff5537a1
      : 0xff7a7877);

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.grey[800],
      scaffoldBackgroundColor: const Color(0xff363645),
      textTheme: ThemeData.dark().textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff2c2c38)),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xff2f2f3d),
        unselectedItemColor: Colors.grey[500],
        selectedIconTheme: const IconThemeData(size: 26),
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 13),
      ),
      appBarTheme: AppBarTheme(
         backgroundColor: appBarColor
       ),
      iconTheme: const IconThemeData(color: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
