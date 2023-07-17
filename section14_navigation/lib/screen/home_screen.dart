import 'package:flutter/material.dart';
import 'package:section14_navigation/layout/main_layout.dart';
import 'package:section14_navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // true - pop 가능
        // false - pop 불가능

        // 작업 따로 설정
        final canPop = Navigator.of(context).canPop();

        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).canPop();
            },
            child: Text('Can Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: Text(
              'Maybe Pop',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Pop'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => RouteOneScreen(
                    number: 123,
                  ),
                ),
              );

              print(result);
            },
            child: Text('Push!'),
          ),
        ],
      ),
    );
  }
}
