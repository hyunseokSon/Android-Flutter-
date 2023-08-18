import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreenStreamBuilder extends StatefulWidget {
  const HomeScreenStreamBuilder({super.key});

  @override
  State<HomeScreenStreamBuilder> createState() => _HomeScreenBuilderState();
}

class _HomeScreenBuilderState extends State<HomeScreenStreamBuilder> {
  // TextStyle 정의
  final textStyle = TextStyle(
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: StreamBuilder(
              stream: streamNumbers(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'StreamBuilder',
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      'ConState : ${snapshot.connectionState}',
                      style: textStyle,
                    ),
                    Text(
                      'Data : ${snapshot.data}',
                      style: textStyle,
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Data : ${snapshot.data}',
                    //     ),
                    //     // Data 자리에서만 로딩 원이 그려지도록 한다.
                    //     if(snapshot.connectionState == ConnectionState.waiting)
                    //       CircularProgressIndicator(),
                    //   ],
                    // ),
                    Text(
                      'Error : ${snapshot.error}',
                      style: textStyle,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('setState'),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed((Duration(seconds: 3)));
    final random = Random();

    // 에러를 발생한다고 가정했을 때
    // throw Exception(
    //     '에러가 발생했습니다.'
    // );


    // 정상적인 값을 반환할 때
    // 정상적으로 반환하면 error = null 값이 된다.
    return random.nextInt(100);
  }

  Stream<int> streamNumbers() async* {
    for(int i=0; i<10; i++) {
      // 예외를 던진다고 가정했을 때
      if (i==5) {
        throw Exception('i=5');
      }
      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }
}
