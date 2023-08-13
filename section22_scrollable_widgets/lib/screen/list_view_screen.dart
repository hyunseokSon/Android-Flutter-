import 'package:flutter/material.dart';
import 'package:section22_scrollable_widgets/const/colors.dart';
import 'package:section22_scrollable_widgets/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparated(),
    );
  }

  // 1. 그냥 ListView만 사용하기
  // 모두 한 번에 그린다.
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
    );
  }

  // 2. ListView ItemBuilder 사용하기
  // 보이는 것만 그린다.
  Widget renderBuilder() {
    return ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        });
  }

  // ListView SeparatedBuilder 사용하기
  // 2 + 중간 중간에 추가할 위젯을 넣을 수 있다.
  Widget renderSeparated() {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index);
      },
      separatorBuilder: (context, index) {
        index += 1;

        // 5개의 item마다 배너 보여주기
        if(index % 5 == 0) {
          return renderContainer(
              color: Colors.black,
              index: index,
              height: 100);
        }

        return Container();
      },
    );
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
