import 'package:flutter/material.dart';
import 'package:tabbar_and_listview/tabbar_screen/secondPage.dart';

import 'firstPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
        length: 2,
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabbar Example'),
      ),
      body: TabBarView(
        children: [
          FirstApp(),
          SecondApp(),
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(
            icon: Icon(
            Icons.looks_one,
            color: Colors.blue,
          ),
          ),
          Tab(
            icon: Icon(
              Icons.looks_two,
              color: Colors.blue,
            ),
          )
        ],
        controller: controller,
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();

    super.dispose();
  }
}
