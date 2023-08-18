import 'package:flutter/material.dart';

import '../const/tabs.dart';

class AppBarUsingController extends StatefulWidget {
  const AppBarUsingController({super.key});

  @override
  State<AppBarUsingController> createState() => _AppBarUsingControllerState();
}

class _AppBarUsingControllerState extends State<AppBarUsingController>
    with TickerProviderStateMixin {
  // 값을 나중에 지정하겠다.
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: TABS.length, vsync: this);

    //tabController 상태 변경될때마다 콜백함수를 실행한다.
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Using Controller'),
        bottom: TabBar(
          controller: tabController,
          tabs: TABS
              .map(
                (e) => Tab(
                  icon: Icon(e.icon),
                  child: Text(
                    e.label,
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map((e) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      e.icon,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (tabController.index != 0)
                          ElevatedButton(
                            onPressed: () {
                              tabController.animateTo(
                                // 인덱스 값
                                tabController.index - 1,
                              );
                            },
                            child: Text(
                              '이전',
                            ),
                          ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        if (tabController.index != TABS.length - 1)
                          ElevatedButton(
                            onPressed: () {
                              tabController.animateTo(
                                // 인덱스 값
                                tabController.index + 1,
                              );
                            },
                            child: Text(
                              '다음',
                            ),
                          ),
                      ],
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
