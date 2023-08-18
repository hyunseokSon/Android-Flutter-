import 'package:flutter/material.dart';

/** 초기 : StatelessWidget
 *  이를 StatefulWidget으로 변경한다.
 *  초기 코드는 아래와 같다.
 **/
class HomeScreen extends StatefulWidget {
  final Color color;

  HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key) {
    print('Widget Constructor 실행!');
  }

  @override
  State<HomeScreen> createState() {
    print('createState 실행!');
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int number = 0;

  // 생명 주기 테스트
  @override
  void initState() {
    print('initState 실행!');
    super.initState();
  }

  // 생명 주기 테스트
  @override
  void didChangeDependencies() {
    print('didChangeDependencies 실행!');
    super.didChangeDependencies();
  }

  // 생명 주기 테스트
  @override
  void deactivate() {
    print('deactivate 실행!');
    super.deactivate();
  }

  // 생명 주기 테스트
  @override
  void dispose() {
    print('dispose 실행!');
    super.dispose();
  }

  // 생명 주기 테스트
  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    print('didUpdateWidget 실행!');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('Build 실행!');

    // GestureDetector : 화면 인식할 수 있는 모든 행동들을
    // 집어넣을 수 있다. (tab, zoom, 길게 누르기 등등...)
    // child 안에 감싸진 부분에 대해서만 행동 제어를 한다.
    return GestureDetector(
      onTap: () {
        // 상태가 dirty로 바뀌고 build가 다시 실행됨.
        // 이후 다시 clean 상태로 바뀐다.
        setState(() {
          number++;
        });

        //print('클릭!');
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        color: widget.color,
        child: Center(
          child: Text(
              number.toString()
          ),
        ),
      ),
    );
  }
}

/** StatefulWidget 으로
 * 직접 코드를 변경해보자 **/
//
// class HomeScreen extends StatefulWidget {
//   final Color color;
//   // 생성자
//   const HomeScreen({
//     required this.color;
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     // private으로 작성!
//    return _HomeScreenState();
//   }
// }
//
// // state는 재사용하므로 color를 생성자로 작성하면 안된다!
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50.0,
//       height: 50.0,
//       color: widget.color,
//     );
//   }
// }

// StatefulWidget을 한 번에 생성하는 방법 : stful 로 생성하자!
