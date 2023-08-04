import 'package:flutter/material.dart';
import 'package:tabbar_and_listview/listview_screen/firstPage.dart';
import 'package:tabbar_and_listview/listview_screen/secondPage.dart';
import 'animalItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Animal> animalList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    // 동물 추가
    animalList.add(
        Animal(animalName: "벌", kind: "곤충", imagePath: "images/bee.png"));
    animalList.add(Animal(
        animalName: "고양이", kind: "포유류", imagePath: "images/cat.png"));
    animalList.add(Animal(
        animalName: "젖소", kind: "포유류", imagePath: "images/cow.png"));
    animalList.add(Animal(
        animalName: "강아지", kind: "포유류", imagePath: "images/dog.png"));
    animalList.add(Animal(
        animalName: "여우", kind: "포유류", imagePath: "images/fox.png"));
    animalList.add(Animal(
        animalName: "원숭이", kind: "영장류", imagePath: "images/monkey.png"));
    animalList.add(Animal(
        animalName: "돼지", kind: "포유류", imagePath: "images/pig.png"));
    animalList.add(Animal(
        animalName: "늑대", kind: "포유류", imagePath: "images/wolf.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: TabBarView(
        children: [
          FirstApp(list: animalList,),
          SecondApp(list: animalList,),
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
