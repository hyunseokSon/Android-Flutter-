import 'package:flutter/material.dart';
import 'animalItem.dart';

class SecondApp extends StatefulWidget {
  final List<Animal> list;

  const SecondApp({required this.list, super.key});

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  final nameController = TextEditingController();
  int? _radioValue = 0;
  bool? flyExist = false;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('양서류'),
                  Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('파충류'),
                  Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('포유류'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('날 수 있나요?'),
                  Checkbox(
                    value: flyExist,
                    onChanged: (bool? check) {
                      setState(() {
                        flyExist = check;
                      });
                    },
                  )
                ],
              ),
              Container(
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
                        'images/dog.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'images/dog.png';
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
              ElevatedButton(
                child: Text('동물 추가하기'),
                onPressed: () {
                  var animal = Animal(
                    animalName: nameController.value.text,
                    kind: getKind(_radioValue),
                    imagePath: _imagePath,
                    flyExist: flyExist,
                  );

                  AlertDialog dialog = AlertDialog(
                    title: Text('동물 추가하기'),
                    content: Text(
                      '이 동물은 ${animal.animalName} 입니다. '
                      '또 동물의 종류는 ${animal.kind}입니다.\n 이 동물을 추가하시겠습니까?',
                      style: TextStyle(fontSize: 30),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          widget.list?.add(animal);
                          Navigator.of(context).pop();
                        },
                        child: Text('예'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('아니오'),
                      ),
                    ],
                  );

                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _radioChange(int? value) {
    setState(() {
      _radioValue = value;
    });
  }

  getKind(int? radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}
