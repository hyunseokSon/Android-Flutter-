import 'package:flutter/material.dart';
import 'package:section22_scrollable_widgets/const/colors.dart';
import 'package:section22_scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      // renderSimple(),
      // renderAlwaysScroll(),
      body: renderPerformance(),
    );
  }

  // 1. 기본 랜더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(color: e),
            )
            .toList(),
      ),
    );
  }

  // 2. 화면을 넘어가지 않아도 스크롤 되게 하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 3. 위젯이 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      // 잘렸을 때 어떤 방식으로 잘렸을 건지를 의미함.
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 4. 여러가지 physics 정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨
      // AlwaysScrollableScrollPhysics - 스크롤 됨
      // BouncingScrollPhysics - IOS 스타일
      // ClampingScrollPhysics - AOS 스타일
      physics: ClampingScrollPhysics(),
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(color: e),
            )
            .toList(),
      ),
    );
  }

  //5. SingleChildScrollView 퍼포먼스
  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers.map(
              (e) => renderContainer(
            color: rainbowColors[e % rainbowColors.length],
            index: e,
          ),
        ).toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if (index != null) {
      print(index);
    }

    return Container(
      height: 300,
      color: color,
    );
  }
}