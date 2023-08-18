import 'package:flutter/material.dart';
import 'package:section24_tabbar/const/tabs.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
        length: TABS.length,
        vsync: this);

    controller.addListener(() {
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar'),
      ),
      body: TabBarView(
        controller: controller,
        children: TABS.map(
            (e) => Center(
              child: Icon(
                e.icon,
              ),
            )
        ).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selected 의 여러가지 속성이 존재한다.
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,

        // 선택된 탭의 Label을 보여줄 것인지를 의미
        showSelectedLabels: true,
        showUnselectedLabels: true,

        // 탭바랑 화면 연동하기
        currentIndex: controller.index,

        // 선택되었을 때 확대되는 것 없애기
        // fixed, shifting이 있다.
        type: BottomNavigationBarType.fixed,

        // 몇 번 탭이 눌렸고, 누를 때마다 이 함수가 실행된다.
        // controller로 해당 탭으로 이동해주면 된다.
        onTap: (index) {
          controller.animateTo(index);
        },
        items: TABS.map(
            (e) => BottomNavigationBarItem(
                icon: Icon(
                  e.icon,
                ),
              label: e.label,
            ),
        ).toList(),
      ),
    );
  }
}
