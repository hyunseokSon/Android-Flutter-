import 'package:flutter/material.dart';
import 'package:section14_navigation/layout/main_layout.dart';

class RouteThreeScreen extends StatelessWidget {
  const RouteThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // two 에서 arguments를 받아오기 위한 변수
    final argument = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Three',
      children: [
        Text(
          'argument : ${argument.toString()}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
      ],
    );
  }
}
