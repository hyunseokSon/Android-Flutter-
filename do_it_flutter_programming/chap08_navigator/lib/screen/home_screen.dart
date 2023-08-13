import 'package:chap08_navigator/screen/first_screen/first_screen.dart';
import 'package:chap08_navigator/screen/second_screen/second_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('현석이의 새 도전'),
        ),
        body: TabBarView(
          children: [
            FirstScreen(),
            SecondScreen(),
          ],
          controller: tabController,
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.subway,
                color: Colors.red,
              ),
              text: "PageRoute",
            ),
            Tab(
              icon: Icon(
                Icons.next_plan,
                color: Colors.red,
              ),
              text: "To-do",
            ),
          ],
          controller: tabController,
        ),
      ),
    );
  }
}
