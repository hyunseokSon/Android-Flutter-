import 'package:flutter/material.dart';

import 'cam_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: _Logo(),
            ),
            Expanded(
              child: _Image(),
            ),
            Expanded(child: _Button()),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          // 모서리 부분을 동글게 만들기 위한 코드
          borderRadius: BorderRadius.circular(16.0),
          // 그림자 처리 -> List 형식으로 여러 개를 넣을 수 있다.
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300]!,
              // 흐려지는 Effect가 얼마나 넓게 가져갈거냐를 의미
              blurRadius: 12.0,
              // 얼마나 퍼져있는지를 의미
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(width: 12.0),
              Text(
                'Live',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    letterSpacing: 4.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'asset/img/home_img.png'
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => CamScreen(),
              )
            );
          },
          child: Text('입장하기'),
        ),
      ],
    );
  }
}
