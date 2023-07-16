import 'dart:math';

import 'package:flutter/material.dart';
import 'package:section12_navigation_slider_random_number/component/number_row.dart';
import 'package:section12_navigation_slider_random_number/constant/color.dart';
import 'package:section12_navigation_slider_random_number/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;

  List<int> randomNumbers = [
    123,
    456,
    789,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                onPressed: onSettingsPop,
              ),
              _Body(
                randomNumbers: randomNumbers,
              ),
              _Footer(onPressed: onRandomNumberGenerate),
            ],
          ),
        ),
      ),
    );
  }

  void onSettingsPop() async {
    // list - add
    // [HomeScreen(), SettingsScreen()]
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingsScreen(maxNumber: maxNumber,);
        },
      ),
    );

    // null 인 경우 체크
    if(result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }

  void onRandomNumberGenerate() {
    final rand = Random();

    // 중복 방지를 위해 Set 자료구조 활용!
    final Set<int> newNumbers = {};

    // 3개의 숫자가 들어갈 때까지 반복
    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);

      newNumbers.add(number);
    }

    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          // 미래에 반환하는 값을 받기 위해 'async' 선언을 해주어야 한다!
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({required this.randomNumbers, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map(
              (x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                child: NumberRow(
                  number: x.value,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return

        /// 2번 방법
        Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // 주 색상
              primary: RED_COLOR,
            ),
            onPressed: onPressed,
            child: Text(
              '생성하기 !',
            ),
          ),
        ),
      ],
    );

    /// 1번 방법
    // SizedBox(
    //   width: double.infinity,
    //   child: ElevatedButton(
    //       onPressed: (){},
    //       child: Text(
    //         '생성하기 !',
    //       ),
    //   ),
    // )
  }
}
