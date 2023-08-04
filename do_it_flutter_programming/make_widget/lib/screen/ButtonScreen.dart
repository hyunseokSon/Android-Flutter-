import 'package:flutter/material.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  var switchValue = false;
  String test = 'hello'; // 버튼에 들어갈 텍스트 입력
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(
            '$test'
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_color),
          ),
          onPressed: () {
            // 클릭 시 버튼의 text 변경하기
            if (_color == Colors.blue) {
              setState(() {
                test = 'flutter';
                // 버튼 색깔 변경
                _color = Colors.amber;
              });
            }

            else {
              setState(() {
                test = 'hello';
                _color = Colors.blue;
              });
            }
          },
        ),
      ),
    );
  }
}
