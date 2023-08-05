import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'animalItem.dart';

class CupertinoSecondPage extends StatefulWidget {
  final List<Animal> animalList;

  const CupertinoSecondPage({
    required this.animalList,
    super.key});

  @override
  State<CupertinoSecondPage> createState() => _CupertinoSecondPageState();
}

class _CupertinoSecondPageState extends State<CupertinoSecondPage> {
  TextEditingController? _textController; // 동물 이름
  int _kindChoice = 0; // 동물 종류
  bool _flyExist = false; // 날개 유무
  String? _imagePath; // 동물 이미지

  // Map 추가
  Map<int, Widget> segmentWidgets = {
    0: SizedBox(
      child: Text(
        '양서류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
    1: SizedBox(
      child: Text(
        '포유류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
    2: SizedBox(
      child: Text(
        '파충류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('동물 추가'),
      ),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: CupertinoTextField(
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              CupertinoSegmentedControl(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  groupValue: _kindChoice,
                  children: segmentWidgets,
                  onValueChanged: (int value) {
                    setState(() {
                      _kindChoice = value;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('날개가 존재합니까?'),
                  CupertinoSwitch(
                    value: _flyExist,
                    onChanged: (value) {
                      setState(() {
                        _flyExist = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        'images/cow.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'images/cow.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'images/pig.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'images/pig.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'images/bee.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'images/bee.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'images/cat.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'images/cat.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'images/fox.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'images/fox.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'images/monkey.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'images/monkey.png';
                      },
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  widget.animalList?.add(Animal(
                    animalName: _textController?.value.text,
                    kind: getKind(_kindChoice),
                    imagePath: _imagePath,
                    flyExist: _flyExist,
                  ));
                },
                child: Text(
                  '동물 추가하기'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "포유류";
      case 2:
        return "파충류";
    }
  }
}
