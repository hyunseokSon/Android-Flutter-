import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 기본값을 현재 날짜로 지정한다.
  DateTime selectedDate = DateTime(
    DateTime
        .now()
        .year,
    DateTime
        .now()
        .month,
    DateTime
        .now()
        .day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 100~900 까지 색 값읇 변경해줄수 있다. 500이 기본값이다.
        backgroundColor: Colors.pink[100],
        body: SafeArea(
          bottom: false,
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              children: [
                _TopPart(
                  selectedDate: selectedDate,
                  onPressed: onHeartPressed,
                ),
                _BottomPart(),
              ],
            ),
          ),
        ));
  }

  onHeartPressed() {
    final DateTime now = DateTime.now();

    // dialog
    showCupertinoDialog(
        context: context,
        // 흰색 Container 바깥 부분을 누르면 닫힌다.
        barrierDismissible: true,
        builder: (BuildContext context) {
          // dialog 작성
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 300.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                // 초기 날짜 설정
                initialDateTime: selectedDate,

                // 최대 날짜 설정
                maximumDate: DateTime(
                  now.year,
                  now.month,
                  now.day,
                ),
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    // 선택한 날짜로 지정!
                    selectedDate = date;
                  });
                },
              ),
            ),
          );
        });
  }
}

// private 을 위해 '_' 로 시작!
// 윗 부분에 해당하는 UI 디자인 코드

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  // 생성자 작성
  _TopPart({required this.selectedDate, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 테마 인스턴스를 가져온다.
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final now = DateTime.now();

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U&I',
            style: textTheme.headline1,
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난 날',
                style: textTheme.bodyText1,
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate
                    .day}',
                style: textTheme.bodyText2,
              ),
            ],
          ),
          IconButton(
            iconSize: 60.0,
            onPressed: onPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${DateTime(
              now.year,
              now.month,
              now.day,
            )
                .difference(selectedDate)
                .inDays + 1}',
            style: textTheme.headline2,
          ),
        ],
      ),
    );
  }
}

// 하위 UI 작성
class _BottomPart extends StatelessWidget {
  const _BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset(
        'asset/img/middle_image.png',
      ),
    );
  }
}
