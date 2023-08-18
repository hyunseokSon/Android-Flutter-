import 'package:flutter/material.dart';

void main() {
  // 현재 시간과 날짜 가져오기
  DateTime now = DateTime.now();

  // 현재 시간, 날짜
  print(now);
  print(now.year); // 년도 출력
  print(now.month); // 달 출력
  print(now.day); // 일 출력
  print(now.hour); // 시간 출력
  print(now.minute); // 분 출력
  print(now.second); // 초 출력
  print(now.millisecond); // 소수점 초 출력

  // Duration - 기간, 아래 코드는 60초를 의미한다.
  Duration duration = Duration(seconds: 60); // 60초의 기간은 ?
  print(duration);
  print(duration.inDays); // 60초의 기간? = 0일
  print(duration.inHours); // 60초의 시간? = 0 시간
  print(duration.inMinutes); // 60초의 분 => 1분
  print(duration.inSeconds); // 60초 출력

  // 특정 날짜 지정하기
  DateTime specificDays = DateTime(
    2017,
    11,
    23,
  );

  print(specificDays);

  // 날짜 차이 계산
  final diff = now.difference(specificDays);
  print(diff);
  print(diff.inDays); // 날짜 차이
  print(diff.inHours); // 시간 차이
  print(diff.inMilliseconds); // 밀리 세컨 차이

  // 다음 날짜인지 체크
  print(now.isAfter(specificDays));
  // 이전 날짜인지 체크
  print(now.isBefore(specificDays));

  // 특정 기간을 더하고 뺄 수 있다!

  // 10시간 더하는 계산
  print(now.add(Duration(hours: 10)));
  // 20초 빼는 계산
  print(now.subtract(Duration(seconds: 20)));
}