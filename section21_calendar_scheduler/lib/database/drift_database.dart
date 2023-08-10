// private 값들은 불러올 수 없다.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:section19_calendar_scheduler/model/category_color.dart';
import 'package:section19_calendar_scheduler/model/schedule_with_color.dart';
import '../model/schedule_table.dart';

import 'package:path/path.dart' as p;

// private 값까지 가져올 수 있다.
// g : generated : 자동으로 생성됐다.
part 'drift_database.g.dart';

// decorator
@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)
// part 'drift_database.g,dart' 에 저장된다.
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  // Insert
  // Insert할 때 무조건 SchedulesCompanion을 인자로 넣어주어야 한다.
  // Insert 시 ID값을 자동으로 return받을 수 있다.
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  // Select Query
  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  // Update Query
  Future<int> updateScheduleById(int id, SchedulesCompanion data) =>
      (update(schedules)..where((tbl) => tbl.id.equals(id))).write(data);

  // 특정 id로 schedule 찾기
  Future<Schedule> getScheduleById(int id) =>
      (select(schedules)..where((tbl) => tbl.id.equals(id))).getSingle();

  // Delete Query
  // go : 모든 row들이 삭제된다.
  // removeSchedule() => delete(schedules).go();
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // Stream 으로 값을 받으면 화면 업데이트가 가능하다!
  // where query 적용 전
  // Stream<List<Schedule>> watchSchedules() =>
  //     select(schedules).watch();

  // where query 적용 후
  // 여기서 2가지 방법으로 발전이 가능하다.
  // Stream<List<Schedule>> watchSchedules(DateTime date) =>
  //     select(schedules).where((tbl) => tbl.date.equals(date)).watch();

  /// 1번 방법.[정석]
  // Stream<List<Schedule>> watchSchedules(DateTime date) {
  //   final query = select(schedules);
  //   query.where((tbl) => tbl.date.equals(date));
  //   return query.watch();
  // }

  /// 2번 방법.[야매]

  // Stream<List<Schedule>> watchSchedules(DateTime date) {
  //   return (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
  // }

  /// 1번 방법에 SQL join 적용시키기
  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    final query = select(schedules).join([
      // 다른 테이블의 이름, 조건 을 넣어준다.
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId))
    ]);

    // join을 했기 때문에 table을 정확하게 명시해줘야 한다.
    query.where(schedules.date.equals(date));

    // 시간 순으로 정렬 (orderBy)
    query.orderBy(
      [
        // asc - 오름차순, desc - 내림차순
        OrderingTerm.asc(schedules.startTime),
      ]
    );


    // rows는 모든 데이터, row는 각각의 데이터를 의미함.
    return query.watch().map((rows) => rows
        .map(
          (row) => ScheduleWithColor(
            schedule: row.readTable(schedules),
            categoryColor: row.readTable(categoryColors),
          ),
        )
        .toList());
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // 배정받은 폴더의 위치를 가져온다.
    final dbFolder = await getApplicationDocumentsDirectory();

    // 실제 경로를 가져온 후, 파일을 생성
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}
