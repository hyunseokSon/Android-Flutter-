import 'package:flutter/material.dart';

class FirstSubSubScreen extends StatelessWidget {
  const FirstSubSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('세 번째 페이지'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '첫 번째 탭, 세 번째 페이지',
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  '첫 번째 페이지로 돌아가기',
                ),
              ),
              Text(
                args,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
