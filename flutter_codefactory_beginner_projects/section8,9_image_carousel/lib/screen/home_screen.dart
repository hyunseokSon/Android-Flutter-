import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    // 초기 page
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    // Timer 만들기
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      // 현재 페이지
      int curPage = controller.page!.toInt();

      // 다음 페이지
      int nextPage = curPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }

      controller.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      // null이 아니라고 표시해줘야 한다!
      timer!.cancel();
    }

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 상단 시간 & 배터리 등 검은색으로 지정
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      // Scroll 기능
      body: PageView(
        // controller 지정하기
        controller: controller,

        children:
        /** 클린 코드 적용 후 **/
        [1, 2, 3, 4, 5].map(
              (e) =>
              Image.asset(
                'asset/img/image_$e.jpeg',
                fit: BoxFit.cover,
              ),
        ).toList(),

        // [
        /** 클린 코드 적용 전 **/
        // Image.asset('asset/img/image_1.jpeg',
        // // 비율을 늘려 전체 크기를 만듬( 가로, 세로 짤릴 수 있음)
        //
        // fit: BoxFit.cover,),
        // Image.asset('asset/img/image_2.jpeg',
        //   fit: BoxFit.cover,),
        // Image.asset('asset/img/image_3.jpeg',
        //   fit: BoxFit.cover,),
        // Image.asset('asset/img/image_4.jpeg',
        //   fit: BoxFit.cover,),
        // Image.asset('asset/img/image_5.jpeg',
        //   fit: BoxFit.cover,),
        //
        // ],
      ),
    );
  }
}
