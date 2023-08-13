import 'package:flutter/material.dart';
import 'package:section22_scrollable_widgets/const/colors.dart';

import '../layout/main_layout.dart';

class ScrollbarScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ScrollbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ScrollBarScreen',
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: numbers.map(
                (e) => renderContainer(
                    color: rainbowColors[e % rainbowColors.length],
                    index: e),
            ).toList(),
          ),
        ),
      ),

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
