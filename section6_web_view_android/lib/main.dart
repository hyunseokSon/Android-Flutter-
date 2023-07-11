import 'package:flutter/material.dart';
import 'package:web_view_android/screen/home_screen.dart';

void main() {
  /** Flutter 프레임워크가 앱을 실행할 준비가 될 때까지 기다린다. **/
  // 웹뷰 최신 버전을 쓰려면 다음 코드로 작성해야 한다!
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}