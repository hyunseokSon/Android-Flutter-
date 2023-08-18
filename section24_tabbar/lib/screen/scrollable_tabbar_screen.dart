import 'package:flutter/material.dart';

import '../const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length * 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Basic App Bar Screen'),
            bottom: TabBar(
              // 선택되었을 때 색깔
              indicatorColor: Colors.red,

              // 선택되었을 때 두께 두껍게 만들기
              indicatorWeight: 4.0,

              // indicator의 크기를 tab, label의 크기에 따라 사용할 수 있다.
              // label을 선택하면 해당 분류의 label의 길이에 따라 indicator가 설정된다.
              indicatorSize: TabBarIndicatorSize.label,

              // 스크롤 가능한지 여부 (좌-우 스크롤 가능)
              isScrollable: true,

              tabs: [
                ...TABS,
                ...TABS,
                ...TABS,
              ].map(
                    (e) => Tab(
                  icon: Icon(
                    e.icon,
                  ),
                  child: Text(
                    e.label,
                  ),
                ),
              ).toList(),
            ),
          ),
          body: TabBarView(
            // 움직일 수 없게 조작!
            physics: NeverScrollableScrollPhysics(),
            children: [
              ...TABS,
              ...TABS,
              ...TABS,
            ].map(
                    (e) => Center(
                  child: Icon(
                    e.icon,
                  ),
                )
            ).toList(),
          )
      ),
    );
  }
}
