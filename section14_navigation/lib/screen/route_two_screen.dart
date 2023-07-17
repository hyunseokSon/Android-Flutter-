import 'package:flutter/material.dart';
import 'package:section14_navigation/layout/main_layout.dart';
import 'package:section14_navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ModalRoute는 FullScreen을 의미한다.
    // 특정 상황에서는 ModalRoute를 못가져올 수 있다.
    // 현재는 그런 상황이 아니니 null이 아니라는 뜻으로 !를 붙여준다.
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments : ${arguments}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Pop',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // push <-> pushNamed
            Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: Text('Push Named'),
        ),
        ElevatedButton(
          onPressed: () {
            ///  방법 1. pushReplacement 사용하기
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //       builder: (_) => RouteThreeScreen(),
            //   ),
            // );

            ///  방법 2. pushReplacementNamed 사용하기
            Navigator.of(context).pushReplacementNamed(
              '/three',
            );
          },
          child: Text(
            'Push Replacement',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            /// 방법 1. Named 사용X pushAndRemoveUntil
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(
            //       builder: (_) => RouteThreeScreen(),
            //     ),
            //         // route에는 true, false 말고도 settings를 통해 지정 가능!
            //         (route) => route.settings.name == '/',
            // );

            /// 방법 2. Named 사용한 pushNamedAndRemoveUntil
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              // route에는 true, false 말고도 settings를 통해 지정 가능!
              (route) => route.settings.name == '/',
            );
          },
          child: Text('Push and Remove Until'),
        ),
      ],
    );
  }
}
