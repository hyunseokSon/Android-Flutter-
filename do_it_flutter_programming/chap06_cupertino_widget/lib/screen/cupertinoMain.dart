import 'package:chap06_cupertino_widget/screen/cupertinoFunction.dart';
import 'package:flutter/cupertino.dart';
import 'cupertinoFirstPage.dart';
import 'cupertinoSecondPage.dart';
import 'animalItem.dart';

class CupertinoMain extends StatefulWidget {
  const CupertinoMain({super.key});

  @override
  State<CupertinoMain> createState() => _CupertinoMainState();
}

class _CupertinoMainState extends State<CupertinoMain> {
  CupertinoTabBar? tabBar;
  List<Animal> animalList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    tabBar = CupertinoTabBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.alarm)),
      ],
    );

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
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: tabBar!,
        tabBuilder: (context, value) {
          if (value == 0) {
            return CupertinoFirstPage(
              animalList: animalList,
            );
          }
          else if (value == 1) {
            return CupertinoSecondPage(
              animalList: animalList,
            );
          }
          else {
            return CupertinoFunctionClass(
            );
          }
        },
      ),
    );
  }
}
