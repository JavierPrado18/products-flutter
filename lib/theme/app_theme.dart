import 'package:flutter/material.dart';

class AppTheme{

  static ThemeData themeLigth=ThemeData.light(
        useMaterial3: true
      ).copyWith(
        scaffoldBackgroundColor: const Color(0xffB2ECE1),
        primaryColor: const Color(0xff2191FB),

        appBarTheme:const AppBarTheme(
          color: Color(0xffBA274A),
          foregroundColor: Colors.white
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff2191FB),
          foregroundColor: Colors.white
                  )
      );
}