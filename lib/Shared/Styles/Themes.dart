import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constant/constant.dart';

ThemeData DarkTheme=ThemeData(
  scaffoldBackgroundColor:  HexColor('333739'),
  primarySwatch: defaultColor,

  appBarTheme: AppBarTheme(
    titleSpacing: 20.0 ,

    backgroundColor: HexColor('333739'),
    backwardsCompatibility: false,
    iconTheme: IconThemeData(
      color: Colors.white,
      ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:  HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
      ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,

      ),

    ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
    ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      ),
    ),
  );
ThemeData LightTheme=ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: defaultColor,

  appBarTheme: AppBarTheme(
    titleSpacing: 20.0 ,
    backgroundColor: Colors.white,
    backwardsCompatibility: false,
    iconTheme: IconThemeData(
      color: Colors.black,
      ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,

      ),

    ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,

    ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
    ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      ),
    ),


  );