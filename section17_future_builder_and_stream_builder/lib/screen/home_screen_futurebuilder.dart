import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            child: FutureBuilder(
          future: getNumber(),
          builder: (context, snapshot) {
            // 처음 값이 안 들어와 있을 때만 로딩 동그라미를 그려주는 것이 UI적으로 좋다.

            // 첫 번째 경우
            // if (!snapshot.hasData) {
            // 데이터가 있을 때 위젯 랜더링

            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            // 두 번째 경우
            if(snapshot.hasError) {
              // 에러가 났을 때 위젯 랜더링
            }

            // 세 번째 경우(나머지)
            // 로딩중일 때 위젯 랜더링

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'FutureBuilder',
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
    throw Exception(
      '에러가 발생했습니다.'
    );
    // 정상적인 값을 반환할 때
    // 정상적으로 반환하면 error = null 값이 된다.
    // return random.nextInt(100);
  }
}
