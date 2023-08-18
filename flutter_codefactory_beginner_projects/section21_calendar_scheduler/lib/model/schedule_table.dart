import 'package:drift/drift.dart';

class Schedules extends Table {
  // ID, CONTENT, DATE, STARTTIME, ENDTIME, COLORID, CREATEDAT
  // 1, 'asdff', 2021-1-2, 12, 14, 1, 2121-1-2
  // 이때 ID는 자동으로 값이 들어가므로 따로 추가해주지 않아도 된다.

  // 자동으로 값이 들어가는 것(ID, CREATEDAT)은 값을 넣어줄 필요가 없다.

  // PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  // 내용
  TextColumn get content => text()();

  // 일정 날짜
  DateTimeColumn get date => dateTime()();

  // 시작 시간
  IntColumn get startTime => integer()();

  // 끝 시간
  IntColumn get endTime => integer()();

  // Category Color Table ID
  IntColumn get colorId => integer()();

  // 생성 날짜
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now(),
      )();
}
