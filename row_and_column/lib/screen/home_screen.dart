import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // 시스템 영역 상의 공간까지 차지하게 할 수 있다!
        bottom: false,
        child: Container(
          color: Colors.black,

          // 현재 시스템의 사이즈를 가져와서 width 또는 height 지정
          // height: MediaQuery.of(context).size.height,

          child: Column(
            /** 1.mainAxisAlignment : 주축 정렬 **/
            // Column, Row 로 지정 가능!

            // start - 시작 부분에 정렬
            // end - 끝 부분에 정렬
            // center - 가운데 부분에 정렬
            // spaceBetween - 끝과 끝에 위젯 배치, 그 사이에 동일한 간격으로 나머지 위젯이 배치
            // spaceEvenly - 위젯을 같은 간격으로 배치하지만 끝과 끝에도
            // 위젯이 아닌 빈 간격으로 시작한다.
            // spaceAround - spaceEvenly + 끝과 끝 간격은 1/2
            mainAxisAlignment: MainAxisAlignment.start,

            /** 2.CrossAxisAlignment : 반대축 정렬 **/
            // start - 시작
            // end - 끝
            // center - 가운데
            // stretch - 최대한으로 늘린다.
            crossAxisAlignment: CrossAxisAlignment.start,

            /** 3. MainAxisSize : 주축 크기 **/
            // max : 최대,
            // min : 최소
            mainAxisSize: MainAxisSize.max,

            children: [
              /** Expanded, Flexible **/
              /** Row, Column의 children 안에서만 사용가능!! **/
              Flexible(
                /** flex로 비율 지정 가능 **/
                // flex: 2,
                child: Container(
                  color : Colors.red,
                  width : 50.0,
                  height : 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color : Colors.orange,
                  width : 50.0,
                  height : 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color : Colors.yellow,
                  width : 50.0,
                  height : 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color : Colors.green,
                  width : 50.0,
                  height : 50.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}