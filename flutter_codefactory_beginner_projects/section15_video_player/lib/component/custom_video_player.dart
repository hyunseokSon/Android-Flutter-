import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  // 비디오 변수를 먼저 받아온다.
  final XFile video;
  // 다른 영상 선택을 위한 처리 변수 - 외부에서 받아온다.
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video,
    required this.onNewVideoPressed,
    super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;

  // Slider의 value에서 사용되기 위한 영상의 현재 위치 값
  Duration currentPosition = Duration();

  // 한 번 탭하면 버튼들이 사라지도록 만들기 위한 bool 변수
  bool showControls = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initState가 실행하면서 initializeController를 기다려주지 않는다.
    initializeController();
  }

  // 다른 영상이 선택되었을 때 State 변경
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 다른 영상 이라면...
    if(oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  // initState는 항상 동기화되게 수행되어야 하기 때문에
  // 따로 함수 생성을 해준다.
  initializeController() async {
    // 영상이 새로 선택되었을 때, 처음부터 영상을 돌리기 위해 객체를 새롭게 생성한다.
    currentPosition = Duration();
    
    // 1. asset
    // 2. file
    // 3. network
    videoController = VideoPlayerController.file(
      // XFile 형태를 File 형태로 변경하기!
      File(widget.video.path),
    );

    await videoController!.initialize();

    // Slider와 동영상 상태를 일치하게 해주도록 리스너 추가
    videoController!.addListener(() {
      final currentPosition = videoController!.value.position;

      setState(() {
        this.currentPosition = currentPosition;
      });
    });

    // build를 새로 해주는 함수.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return CircularProgressIndicator();
    }

    // VideoPlayer에서 주는 Widget이 있다.
    /// Video를 원래 사이즈로 보여주도록 Return 하기 위해
    /// AspectRatio 위젯을 넣어주면 된다.
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          children: [
            VideoPlayer(videoController!),
            // showControls가 true일 때만 버튼들이 보이도록 설정
            if (showControls)
            _Controls(
              onReservePressed: onReversePressed,
              onPlayPressed: onPlayPressed,
              onForwardPressed: onForwardPressed,
              isPlaying: videoController!.value.isPlaying,
            ),
            // showControls가 true일 때만 버튼들이 보이도록 설정
            if(showControls)
            _NewVideo(
              // 새로운 비디오 선택하기 시
              onPressed: widget.onNewVideoPressed,
            ),
            _SliderBottom(
              currentPosition: currentPosition,
              maxPosition: videoController!.value.duration,
              onSliderChanged: onSliderChanged,
            ),

            /// Positioned 위젯
          ],
        ),
      ),
    );
  }

  // Slider 변화 시 코드
  void onSliderChanged(double val) {
    // Slide를 움직일 때만 호출이 되고, 실제로 영상이 진행될 때는 의미가 없게 됨!
    // setState(() {
    //   currentPosition = Duration(seconds: val.toInt());
    // });

    videoController!.seekTo(Duration(
      seconds: val.toInt(),
    ));
  }

  // 새로운 비디오 선택 시 -> 컴포넌트로 관리해주어야 한다.
  // void onNewVideoPressed() {}

  // 뒤로 가기 버튼 클릭 시
  void onReversePressed() {
    // 1. 현재 지금 영상의 위치를 아는 법.
    final currentPosition = videoController!.value.position;

    // 기본 position은 0초부터 시작하도록 설정.
    Duration position = Duration();

    // 3초보다 더 영상이 진행된 경우
    if (currentPosition.inSeconds > 3) {
      // 뒤로 3초 가기
      // (변경 가능하도록 하기 위해 final이 아닌 Duration으로 선언)
      position = currentPosition - Duration(seconds: 3);
    }

    // 어떤 위치부터 찾을지
    videoController!.seekTo(position);
  }

  // 앞으로 가기 버튼 클릭 시
  void onForwardPressed() {
    // 영상의 최대 길이에 해당하는 위치 반환
    final maxPosition = videoController!.value.duration;
    // 1. 현재 지금 영상의 위치를 아는 법.
    final currentPosition = videoController!.value.position;

    // 기본 position을 최대 길이로 변환.
    Duration position = maxPosition;

    // 전체 영상에서 3초 뺀 것이 현재 포지션보다 길다면
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      // 뒤로 3초 가기
      // (변경 가능하도록 하기 위해 final이 아닌 Duration으로 선언)
      position = currentPosition + Duration(seconds: 3);
    }

    // 어떤 위치부터 찾을지
    videoController!.seekTo(position);
  }

  // 재생 버튼 클릭 시
  void onPlayPressed() {
    // 이미 실행중이면 중지
    // 실행중이 아니면 실행

    // 빌드를 다시 하며 앱에 상태를 반영함
    setState(() {
      if (videoController!.value.isPlaying) {
        // 이미 실행중인 경우
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }
}

// 재생 여부 판단
class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReservePressed;
  final VoidCallback onForwardPressed;

  // 실행 중인지, 멈춰져있는지 판단하는 변수
  final bool isPlaying;

  const _Controls(
      {required this.onPlayPressed,
      required this.onReservePressed,
      required this.onForwardPressed,
      required this.isPlaying,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 배경색에 투명도를 부여하겠다!
      color: Colors.black.withOpacity(0.5),
      // 높이 최대로 설정하여 문제 1 해결.
      height: MediaQuery.of(context).size.height,
      child: Row(
        // 문제 1. stretch로 하면 버튼 이외의 부분을 클릭해도 해당 버튼을 누른것처럼 이동함
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
              onPressed: onReservePressed, iconData: Icons.rotate_left),
          renderIconButton(
              onPressed: onPlayPressed,
              iconData: isPlaying ? Icons.pause : Icons.play_arrow),
          renderIconButton(
              onPressed: onForwardPressed, iconData: Icons.rotate_right),
        ],
      ),
    );
  }

  // 3개의 버튼을 하나의 함수로 묶어서 표현.
  // 버튼의 차이는 onPressed, IconData만 다르기 때문에 다음과 같이 처리.
  Widget renderIconButton({
    required VoidCallback onPressed,
    required IconData iconData,
  }) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(
        iconData,
      ),
    );
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _NewVideo({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    /// 위치를 정하는 위젯 Positioned
    return Positioned(
      right: 0, // 오른쪽보다 0픽셀만큼 이동시켜라!
      child: IconButton(
        onPressed: onPressed,
        color: Colors.white,
        iconSize: 30.0,
        icon: Icon(
          Icons.photo_camera_back,
        ),
      ),
    );
  }
}

class _SliderBottom extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _SliderBottom(
      {required this.currentPosition,
      required this.maxPosition,
      required this.onSliderChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              // 1의 자리 숫자는 01 초, 15초 와 같이 두 자리로 표현하고 싶을 때 다음과 같이 작성
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
                max: maxPosition.inSeconds.toDouble(),
                min: 0,
              ),
            ),
            Text(
              // 1의 자리 숫자는 01 초, 15초 와 같이 두 자리로 표현하고 싶을 때 다음과 같이 작성
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
