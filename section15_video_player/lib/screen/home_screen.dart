import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:section15_video_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // imagePicker에 존재하는 클래스
  // XFile을 통해 모든 이미지와 동영상 파일을 리턴받을 수 있다.
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Column이 화면 전체를 사용하도록 설정!
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  // 선택한 Video가 존재할 때
  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

  // 비디오를 선택하지 않았을 때
  Widget renderEmpty() {
    return Container(
      // 전체 너비 가져오기
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),
          /// 간격 벌리기
          SizedBox(height: 30.0,),
          _AppName(),
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    // 영상을 고를때까지 기다려줘야 하므로 async, await 사용
    final video = await ImagePicker().pickVideo(
      source : ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A3A7C),
            Color(0xFF000118),
          ]
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;


  const _Logo({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    // 이미지 로고 클릭 시 버튼 클릭 처럼 기능하게 해주는 것!
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
          'asset/image/logo.png'
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({super.key});

  @override
  Widget build(BuildContext context) {
    // textStyle 한 번에 정리하기
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          // textStyle 중 굵기만 따로 지정하기
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

