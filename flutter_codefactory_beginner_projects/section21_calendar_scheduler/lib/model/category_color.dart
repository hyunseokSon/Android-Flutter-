import 'package:drift/drift.dart';

class CategoryColors extends Table {
  // PRIMARY KEY
  // 자동으로 숫자를 증가시킴.
  IntColumn get id => integer().autoIncrement()();

  // 색상 코드
  TextColumn get hexCode => text()();
}