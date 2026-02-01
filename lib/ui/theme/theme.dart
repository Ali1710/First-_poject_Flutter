import 'package:flutter/material.dart';

final darkTheme = ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 27, 26, 26),
        dividerColor: Colors.white,
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
        ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle( 
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        );