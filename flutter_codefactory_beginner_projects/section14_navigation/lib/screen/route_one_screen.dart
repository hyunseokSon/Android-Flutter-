import 'package:flutter/material.dart';
import 'package:section14_navigation/layout/main_layout.dart';
import 'package:section14_navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  // ? 면 있을 수도 있고 없을 수도 있다는 뜻이다.
  final int? number;

  const RouteOneScreen({this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        Text(
          'arguments : ${number.toString()}',
          textAlign: TextAlign.center,
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
            Navigator.of(context).pop(456);
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => RouteTwoScreen(),

                  /// 값을 전달하는 두 번째 방법
                  settings: RouteSettings(
                    arguments: 789,
                  )),
            );
          },
          child: Text('Push'),
        ),
      ],
    );
  }
}
