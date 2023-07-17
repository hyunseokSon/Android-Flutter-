import 'package:flutter/material.dart';
import 'package:section14_navigation/screen/home_screen.dart';
import 'package:section14_navigation/screen/route_one_screen.dart';
import 'package:section14_navigation/screen/route_three_screen.dart';
import 'package:section14_navigation/screen/route_two_screen.dart';

void main() {
  runApp(
    MaterialApp(
      //home: HomeScreen(),
      // 처음 시작 경로를 명시한다.
      initialRoute: '/',
      // home 부분은 / 를 의미한다.
      routes: {
        '/': (context) => HomeScreen(),
        '/one': (context) => RouteOneScreen(),
        '/two' : (context) => RouteTwoScreen(),
        '/three' : (context) => RouteThreeScreen(),
      },
    ),
  );
}