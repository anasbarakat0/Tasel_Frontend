import 'package:flutter/material.dart';

abstract class AppColors {

  static Color yellow = const Color.fromARGB(255, 255, 204, 0);

  static Color lightYellow = const Color.fromRGBO(255, 226, 105, 1);

  static Color darkYellow = const Color.fromARGB(255, 254, 188, 12);

  static Color grey = const Color.fromARGB(255, 61, 61, 61);

  static Color lightGrey = const Color.fromARGB(255, 163, 163, 163);
}

abstract class AppButtons {
  static ButtonStyle myButtonStyle = ButtonStyle(
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.yellow),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    
  );
}

abstract class AppFont {
  static TextStyle textFieldStyle = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.yellow,
  );
  static TextStyle cairoS = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.darkYellow,
  );
  static TextStyle title = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: AppColors.grey,
  );
}
