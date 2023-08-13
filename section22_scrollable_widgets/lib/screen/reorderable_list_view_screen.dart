import 'package:flutter/material.dart';
import 'package:section22_scrollable_widgets/const/colors.dart';
import 'package:section22_scrollable_widgets/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() => _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(
    100,
      (index) => index
  );

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'ReorderableListViewScreen',
        body: renderBuilder(),
    );
  }

  Widget renderDefault() {
    return ReorderableListView(
      children: numbers.map(
              (e) => renderContainer(
            color: rainbowColors[e % rainbowColors.length],
            index: e,
          )
      ).toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // oldIndex와 newIndex 모두 이동이 되기 전에 산정한다.
          // [red, orange, yellow]
          // [0, 1, 2]

          // red를 yellow 다음으로 옮기고 싶다.
          // red : 0 oldIndex -> 3 newIndex
          // [orange, yellow, red] 로 된다.

          // [red, orange, yellow]
          // yellow를 red 앞으로 옮기고 싶다.
          // yellow : 2 oldIndex -> 0 newIndex
          // [yellow, red, orange]

          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }

  Widget renderBuilder() {
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return renderContainer(
          // 변경 부분 3
          //color: rainbowColors[index % rainbowColors.length],
          color: rainbowColors[numbers[index] % rainbowColors.length],
          // 변경 부분 1
          // index: index,
          index: numbers[index],
        );
      },
      // 변경 부분 2
      // itemCount: 100,
      itemCount: numbers.length,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // oldIndex와 newIndex 모두 이동이 되기 전에 산정한다.
          // [red, orange, yellow]
          // [0, 1, 2]

          // red를 yellow 다음으로 옮기고 싶다.
          // red : 0 oldIndex -> 3 newIndex
          // [orange, yellow, red] 로 된다.

          // [red, orange, yellow]
          // yellow를 red 앞으로 옮기고 싶다.
          // yellow : 2 oldIndex -> 0 newIndex
          // [yellow, red, orange]

          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
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
      key: Key(index.toString()),
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
