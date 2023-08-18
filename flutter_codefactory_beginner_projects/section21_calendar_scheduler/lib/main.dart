import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:section19_calendar_scheduler/database/drift_database.dart';
import 'package:section19_calendar_scheduler/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  // 빨강
  'F44336',
  // 주황
  'FF9800',
  // 노랑
  'FFEB3B',
  // 초록
  'FCAF50',
  // 파랑
  '2196F3',
  // 남색
  '3F51B5',
  // 보라
  '9C27B0',
];


void main() async{
  // await ininitializeDateFormatting(); 를 하기 전에 플러터 프레임워크에게 준비시간을 준다.
  // 원래는 runApp() 시 자동으로 실행되지만, runApp() 이전에 플러터 관련 코드가 들어가게 되면
  // 이 Binding을 먼저 해주어야 한다.
  WidgetsFlutterBinding.ensureInitialized();

  // 모든 언어를 사용할 수 있게 된다.
  await initializeDateFormatting();

  // 색상 정보 DB에 넣기
  final database = LocalDatabase();

  // I는 인스턴스를 의미함.
  // Getit을 통해 어디서든 database값을 가져올 수 있다.
  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();

  // 중복으로 값이 들어가지면 안되니, 값이 있는지 먼저 확인한다.
  // DB에 값이 비어있는지 확인
  if (colors.isEmpty) {
    // 값이 들어있는지 확인하기 위해 출력 찍어보기.
    // print('실행!');

    for(String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          // ID는 자동 생성됨 (autoIncrement)
          hexCode: Value(hexCode),
        )
      );
    }
  }

  // 값이 잘 들어가 있는지 확인
  // print(await database.getCategoryColors());

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: HomeScreen(),
    ),
  );
}
