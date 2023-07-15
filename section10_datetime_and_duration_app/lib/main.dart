import 'package:flutter/material.dart';
import 'package:section10_datetime_and_duration_app/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      // 테마 적용
      theme: ThemeData(
        // 기본 폰트 변경
        fontFamily: 'sunflower',

          textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontFamily: 'parisienne',
          fontSize: 80.0,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 50.0,
          fontWeight: FontWeight.w700,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      )),
      home: HomeScreen(),
    ),
  );
}
