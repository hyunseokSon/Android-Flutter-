import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:section18_video_call/const/agora.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;

  // 화상 채팅에 접속했을 때 내 ID
  int? uid = 0; // 채널에 접속하기 전 임의의 ID,
  // 채널에 접속하면 실제로 접속한 것으로 인식한다.

  // 상대 ID
  int? otherUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live'),
      ),
      body: FutureBuilder<bool>(
          future: init(),
          builder: (context, snapshot) {
            // 에러가 있는지를 판단
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            // 로딩 중인 경우
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Stack(
                      children: [
                        // 첫 번째 스택
                        renderMainView(),
                        // Align으로 정렬
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            color: Colors.grey,
                            height: 160,
                            width: 120,
                            child: renderSubView(),
                          ),
                        ),
                      ],
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        // engine이 꺼지지 않았다면 채널이 나가고 엔진을 끄기
                        if(engine != null) {
                          await engine!.leaveChannel();
                          engine = null;
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text('채널 나가기'),
                  ),
                ),
              ],
            );
          }),
    );
  }

  // 크게 보일 화면
  renderMainView() {
    if (uid == null) {
      return Center(
        child: Text('채널에 참여해주세요'),
      );
    } else {
      // 채널에 참여하고 있을 때
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: engine!,
          // 어떠한 영상을 보여줄지 입력
          canvas: VideoCanvas(
            uid: 0,
          ),
        ),
      );
    }
  }

  // 작게 보일 화면
  renderSubView() {
    if(otherUid == null) {
      return Center(
        child: Text('채널에 유저가 없습니다.'),
      );
    }

    else {
      return AgoraVideoView(
        // 상대방을 보여주려면 remote를 해주면 된다.
        controller: VideoViewController.remote(
            rtcEngine: engine!,
            canvas: VideoCanvas(uid: otherUid),
            connection: RtcConnection(channelId: CHANNEL_NAME),
        ),
      );
    }
  }

  /// 권한 관리
  Future<bool> init() async {
    // 카메라, 마이크 권한 동시 요청
    final resp = await [Permission.camera, Permission.microphone].request();

    // 권한 여부 확인
    final cameraPermission = resp[Permission.camera];
    final microPhonePermission = resp[Permission.microphone];

    // 권한이 없으면 에러 처리
    if (cameraPermission != PermissionStatus.granted ||
        microPhonePermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    // 엔진이 null일 때 새로운 엔진 생성
    if (engine == null) {
      engine = createAgoraRtcEngine();

      await engine!.initialize(
        RtcEngineContext(
          appId: APP_ID, // 내 앱 ID 배정
        ),
      );

      engine!.registerEventHandler(
        RtcEngineEventHandler(
          // 1. 내가 채널에 입장했을 때
          // connection -> 연결 정보
          // elapsed -> 연결된 시간 (연결된지 얼마나 됐는지를 의미)
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            print('채널에 입장했습니다. uid : ${connection.localUid}');

            // 내 ID 배정하기
            setState(() {
              uid = connection.localUid;
            });
          },
          // 2. 내가 채널에서 나갔을 때
          onLeaveChannel: (RtcConnection connection, RtcStats stats) {
            print('채널 퇴장');
            setState(() {
              uid == null;
            });
          },
          // 3. 상대방 유저가 채널에 입장했을 때
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            print('상대가 채널에 입장했습니다. otherUid : $remoteUid');

            setState(() {
              otherUid = remoteUid;
            });
          },
          // 4. 상대방 유저가 채널에서 나갔을 때
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            print('상대가 채널에서 나갔습니다. otherUid : $remoteUid');

            setState(() {
              otherUid = null;
            });
          },
        ),
      );

      /// 엔진 시작하기
      await engine!.enableVideo();

      /// 카메라로 찍고 있는 모습을 송출하라
      await engine!.startPreview();

      ChannelMediaOptions options = ChannelMediaOptions();

      await engine!.joinChannel(
        token: TEMP_TOKEN,
        channelId: CHANNEL_NAME,
        uid: 0,
        options: options,
      );
    }

    return true;
  }

  // engine에서 채널 나가기 및 폐기 처리하기
  @override
  void dispose() async {
    if(engine != null) {
      await engine!.leaveChannel(
        options: LeaveChannelOptions(),
      );
      engine!.release();
    }
    super.dispose();
  }
}
