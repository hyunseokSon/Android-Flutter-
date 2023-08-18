import 'package:flutter/material.dart';
import 'package:section23_dusty_dust/model/stat_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_container/hive_home_screen.dart';

const testBox = 'test';

void main() async {
  // Hive 초기화
  await Hive.initFlutter();

  // Hive의 어댑터 등록하기 - Generic에 클래스를 넣어주면 된다.
  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  // 어떤 박스를 열지 이름을 정해주어야 한다.
  await Hive.openBox(testBox);

  // 박스 열기
  for(ItemCode itemCode in ItemCode.values) {
    // 박스의 키 값이 itemCode로 들어간다.

    // await Hive.openBox(itemCode.name);
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'sunflower',
    ),
    // home: HomeScreen(),
    home: HiveHomeScreen(),
  ));
}