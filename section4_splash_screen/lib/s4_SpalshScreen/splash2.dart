import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      // 화면 전체에 어떤 UI를 작성할지를 의미한다.

      // 오른쪽 상단에 Debug 선 지우고 싶다면 다음과 같이 작성해주면 된다.
      debugShowCheckedModeBanner: false,
        home: HomeScreen(),
    ),
  );
}

// 위젯 만들기
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 원하는 위젯을 넣어주기
    return Scaffold(
      // 배경색 변경하기
      // backgroundColor: Colors.orange,

      // 정확한 색상 색깔 넣는 법 0xFF.. : FF면 투명도가 없다!
      backgroundColor: Color(0xFFF99231),

      // 텍스트 중간에 배치하기
      body: Column(
        // 주축 정렬 (가운데 정렬)
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('asset/img/logo.png'),
          // 로딩 삽입
          CircularProgressIndicator(
            // 색깔 지정
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
