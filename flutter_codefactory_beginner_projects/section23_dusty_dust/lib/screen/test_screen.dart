import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:section23_dusty_dust/main.dart';
import 'package:section23_dusty_dust/screen/test2_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Test Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // StreamBuilder랑 똑같다.
          // Builder가 다시 실행되기 때문에 값이 변경되었을 때 화면에 바로 보여준다.
          ValueListenableBuilder<Box>(
            // 실제 box의 값들을 불러오기 ,, listenable() 함수 가져와야 한다.
              valueListenable: Hive.box(testBox).listenable(),
              builder: (context, box, widget) {


                return Column(
                  children: box.values.map(
                      (e) => Text(e.toString())
                  ).toList(),
                );
              },
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('keys: ${box.keys.toList()}');
              print('values: ${box.values.toList()}');
            },
            child: Text(
              '박스 프린트하기!',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // 다음과 같이 저장된다.
              // {
              //   0: '테스트1'
              // }

              final box = Hive.box(testBox);

              // 자동으로 데이터 정렬이 된다.

              // box.add : 원하는 값을 넣을 수 있다.
              // box.put : 데이터를 생성하거나, 업데이트할 수 있다.
              // box.put(101, true);

              // map 형태로도 데이터 추가가 가능하다.
              // box.put(103, {
              //   'test' : 'test5',
              // });

              // ㅣist 형태로도 데이터 추가가 가능하다.
              // box.put(103, [
              //   'test1', 'test2'
              // ]);

              box.put(1000, '새로운 데이터!!!');
            },
            child: Text('데이터 넣기!'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // 키에 해당하는 value 값을 가져올 수 있다.
              // print(box.get(2));

              // 몇 번째 값을 가져오는지를 확인할 수 있다.
              print(box.getAt(2));
            },
            child: Text('특정 값 가져오기'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // box.delete(2);
              box.deleteAt(2);
            },
            child: Text('삭제하기'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => Test2Screen()),
              );
            },
            child: Text('다음화면!'),
          ),
        ],
      ),
    );
  }
}
