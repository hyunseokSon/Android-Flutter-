import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://hs0724.tistory.com/');

class HomeScreen extends StatelessWidget {
  /** WebView 선언 **/
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(homeUrl); // uri 타입으로 넣어줘야 한다.

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** AppBar 만들기 **/
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Code Factory'),
        /** Title 위치 변경 **/
        centerTitle: true,

        /** 누르면 홈으로 돌아가는 버튼 하나 추가하기 **/
        actions: [
          IconButton(
              onPressed: () {
                // if(controller == null) {
                //   return;
                // }

                // !로 null이 될 수 없다는 것을 알려줘야 함!
                // controller!.loadUrl(homeUrl);

                // 최신 버전은 이렇게 한다.
                controller.loadRequest(homeUrl);
              },
              icon: Icon(
                Icons.home,
              ))
        ],
      ),
      body:
          /** 최신 버전 webview 구현 **/
          WebViewWidget(
        controller: controller,
      ),

      
      /** 구버전 webView 구현 **/
      // WebView(
      //   /** Controller 생성하기 **/
      //   onWebViewCreated: (WebViewController controller) {
      //     this.controller = controller;
      //   },
      //
      //   initialUrl: homeUrl,
      //   /** 자바 스크립트 사용 설정을 따로 해주어야함! **/
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}
