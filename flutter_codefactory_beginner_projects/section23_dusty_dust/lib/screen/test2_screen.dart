import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';

class Test2Screen extends StatelessWidget {
  const Test2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Test2 Screen'),
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

        ],
      ),
    );
  }
}
