import 'package:flutter/material.dart';

void main() {
  // 현재 시간과 날짜 가져오기
  DateTime now = DateTime.now();

  // 현재 시간, 날짜
  print(now);
  print(now.year);
  print(now.month);
  print(now.day);
  print(now.hour);
  print(now.minute);
  print(now.second);
  print(now.millisecond);

  // Duration - 기간, 아래 코드는 60초를 의미한다.
  Duration duration = Duration(seconds: 60);

  //


}