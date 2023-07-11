import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       // 화면 전체에 어떤 UI를 작성할지를 의미한다.
//         home: HomeScreen()),
//   );
// }

// 위젯 만들기
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 원하는 위젯을 넣어주기
    return Scaffold(
      // 배경색 변경하기
      backgroundColor: Colors.black,
      // 텍스트 중간에 배치하기
      body: Center(
        child:
        // 텍스트 삽입하기
        // Text('Hello world',
        //     // 글자 스타일 변경하기
        //     style: TextStyle(
        //       color: Colors.white,
        //       // 픽셀 크기로 폰트 사이즈 변경하기
        //       fontSize: 20.0,
        //     )),
        // 이미지 삽입하기
        Image.asset('asset/img/logo.png'),
      ),
    );
  }
}
