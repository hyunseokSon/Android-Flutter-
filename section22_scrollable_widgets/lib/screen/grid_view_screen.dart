import 'package:flutter/material.dart';
import 'package:section22_scrollable_widgets/const/colors.dart';

import '../layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderMaxExtent(),
    );
  }

  // GridView에서 count를 썼을 때
  // 한 번에 화면 모두 그린다.
  Widget renderCount() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      children: numbers.map(
              (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e)
      ).toList(),
    );
  }

  // 2. 보이는 것만 그림
  Widget renderBuilderCrossAxisCount() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
        ),
        itemBuilder: (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length],
              index: index);
        });
  }

  // 3. 위젯 하나 당 최대 사이즈 지정
  Widget renderMaxExtent() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // 하나하나 위젯의 최대 길이를 정할 수 있다.
          maxCrossAxisExtent: 200,
        ),
        itemBuilder: (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length],
              index: index);
        });
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    if (index != null) {
      print(index);
    }

    return Container(
      // height: height ?? 300, 처럼 작성해도 된다!
      height: height == null ? 300 : height,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
