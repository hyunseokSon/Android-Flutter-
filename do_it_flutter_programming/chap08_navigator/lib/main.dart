import 'package:chap08_navigator/screen/first_screen/first_screen.dart';
import 'package:chap08_navigator/screen/first_screen/first_sub.dart';
import 'package:chap08_navigator/screen/first_screen/first_subsub.dart';
import 'package:chap08_navigator/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "페이지 이동하기",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/first_sub': (context) => FirstSubScreen(),
        '/first_subsub': (context) => FirstSubSubScreen(),
        // '/third': (context) => ThirdPage(),
      },
    ),
  );
}
