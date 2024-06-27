import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme()=>ThemeData(
    primaryColor: Colors.red,
    primarySwatch: Colors.red,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:Colors.red
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        )

    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        titleLarge: TextStyle(
           fontFamily: 'jannah'
        ),
    )

);