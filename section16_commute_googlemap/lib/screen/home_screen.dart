import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;
  
  // Latitude : 위도, Longitude : 경도
  static final LatLng companyLatLng = LatLng(
    37.5233273, // 위도
    126.921252, // 경도
  );

  // zoom : 확대한 정도를 의미.
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  // 원의 지름을 표현하기 위한 변수
  static final double okDistance = 100;

  // 반경 100m 원 만들기
  // withinDistanceCircle = 반경 내부에 있는 원인 경우
  static final Circle withinDistanceCircle = Circle(
    // circle을 Id로 구분한다.
    circleId: CircleId('withinDistanceCircle'),
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: okDistance,
    // 원 둘레의 색깔
    strokeColor: Colors.blue,
    // 원 둘레의 두께
    strokeWidth: 1, // pixel
  );

  // 반경 100m 원 만들기(2)
  // notWithinDistanceCircle = 반경 외부에 있는 원인 경우
  static final Circle notWithinDistanceCircle = Circle(
    // circle을 Id로 구분한다.
    circleId: CircleId('notWithinDistanceCircle'),
    center: companyLatLng,
    fillColor: Colors.red.withOpacity(0.5),
    radius: okDistance,
    // 원 둘레의 색깔
    strokeColor: Colors.red,
    // 원 둘레의 두께
    strokeWidth: 1, // pixel
  );

  // 반경 100m 원 만들기(3)
  // checkDoneCircle = 작업이 끝난 경우(?)
  static final Circle checkDoneCircle = Circle(
    // circle을 Id로 구분한다.
    circleId: CircleId('checkDoneCircle'),
    center: companyLatLng,
    fillColor: Colors.green.withOpacity(0.5),
    radius: okDistance,
    // 원 둘레의 색깔
    strokeColor: Colors.green,
    // 원 둘레의 두께
    strokeWidth: 1, // pixel
  );

  // 지도에 마커 그리기
  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar 자리
      appBar: renderAppBar(),
      // 원래는 FutureBuilder<String> 이 맞는 형태이다!
      body: FutureBuilder(
        // 권한 여부에 따라 builder를 다시 실행하여 화면에 다시 그린다.
        // 즉, 상태가 변경될 때마다 builder를 다시 그린다.
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // FutureBuilder에서는 none, waiting, done이 있고,
          // StreamBuilder에서는 none, waiting, active, done이 있다.
          // waiting - async의 답변을 대기할 때
          // done - async 함수의 동작이 끝났을 때
          print(snapshot.connectionState);

          // 저장된 허가 권한 값 확인
          print(snapshot.data);

          // 로딩중인 상황일 때
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // 위치 권한이 허가된 경우 지도를 화면에 그리도록 한다.
          if (snapshot.data == '위치 권한이 허가되었습니다.') {
            // 원래 return Column이었던 형태를
            // StreamBuilder를 이용한 Widget으로 감싸주었다!
            return StreamBuilder<Position>(
                // stream 파라미터에서
                // position 타입을 반환하므로 StreamBuilder의 타입도 Position으로 수정한다.
                // 권한을 허락받았기 때문에 사용 가능한 것!
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  // position이 바뀔 때마다 불린다.
                  // lat, longitude 모두 출력된다!
                  print(snapshot.data);

                  // 반경에 포함되어 있는지 여부를 판단하는 변수
                  bool isWithinRange = false;

                  if (snapshot.hasData) {
                    // 현재 나의 위치
                    final start = snapshot.data!;
                    // 회사의 위치
                    final end = companyLatLng;

                    final distance = Geolocator.distanceBetween(
                      start.latitude,
                      start.longitude,
                      end.latitude,
                      end.longitude,
                    );

                    // 거리가 100m보다 작은 경우
                    if (distance < okDistance) {
                      isWithinRange = true;
                    }
                  }

                  return Column(
                    children: [
                      // 지도 위젯
                      _CustomGoogleMap(
                        initialPosition: initialPosition,
                        // 100m 거리 이내에 있는지 여부에 따라 circle에
                        // 값을 다르게 적용한다.
                        circle: choolCheckDone
                            ? checkDoneCircle
                            : isWithinRange
                                ? withinDistanceCircle
                                : notWithinDistanceCircle,
                        marker: marker,
                        onMapCreated: onMapCreated,
                      ),
                      // 지도 하위 부분
                      _ChoolCheckButton(
                        isWithinRange: isWithinRange,
                        onPressed: onChoolCheckPressed,
                        choolCheckDone: choolCheckDone,
                      ),
                    ],
                  );
                });
          }

          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  /** 지도 현재 위치 표현 **/
  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  onChoolCheckPressed() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('출근하기'),
            content: Text('출근을 하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('출근하기'),
              ),
            ],
          );
        });

    if (result) {
      setState(() {
        choolCheckDone = true;
      });
    }
  }

  // 권한 허가
  Future<String> checkPermission() async {
    // 핸드폰 별로 위치 기능을 사용할 수 있는 패널들을 의미
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }

    // 현재 위치 서비스에 대한 권한을 의미한다.
    // LocationPermission : 5개의 값을 가진다.
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    // 권한 허가 요청을 따로 할 수 있는 상태
    if (checkedPermission == LocationPermission.denied) {
      // 권한 요청하는 다이얼로그를 띄운다.
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    // 앱 안에서 위치 권한 허가를 거부했을 때, 세팅에서 앱 권한을 허가하도록 유도해야 함.
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요.';
    }

    // 나머지 값인 whileInUse, always 둘다 권한이 허락된 것이므로
    return '위치 권한이 허가되었습니다.';
  }

  // AppBar
  AppBar renderAppBar() {
    return AppBar(
      title: Text(
        '오늘도 출근',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            if(mapController == null) {
              return;
            }

            final location = await Geolocator.getCurrentPosition();
            
            mapController!.animateCamera(
                CameraUpdate.newLatLng(
                    LatLng(
                        location.latitude,
                        location.longitude),
                ),
            );
          },
          color: Colors.blue,
          icon: Icon(
            Icons.my_location,
          ),
        )
      ],
    );
  }
}

// 지도 위젯
class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const _CustomGoogleMap(
      {required this.initialPosition,
      required this.circle,
      required this.marker,
      required this.onMapCreated,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        // 어떤 형태로 지도를 보여줄지를 지정해줄 수 있다.
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        // 내 위치 찍기
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        // GoogleMap 내부에 circles라는 parameter가 존재한다.
        // 화면에 동시에 보여주고 싶은 것들은 circleId를 다르게 해주어야 한다.
        circles: Set.from([circle]),
        // 원 중심에 마커 그리기
        markers: Set.from([marker]),
        // 현재 위치를 알아내기 위해 Controller가 필요하다.
        onMapCreated: onMapCreated,
      ),
    );
  }
}

// 하단 부분
class _ChoolCheckButton extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool choolCheckDone;

  const _ChoolCheckButton(
      {required this.isWithinRange,
      required this.onPressed,
      required this.choolCheckDone,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_outlined,
            size: 50.0,
            // isWithinRange에 따라 색깔 지정.
            color: choolCheckDone
                ? Colors.green
                : isWithinRange
                    ? Colors.blue
                    : Colors.red,
          ),

          // 간격 지정
          const SizedBox(
            height: 20.0,
          ),
          // if 문을 통해 Button 여부를 보여줄 수 있다.
          if (!choolCheckDone && isWithinRange)
            TextButton(
              onPressed: onPressed,
              child: Text(
                '출근하기',
              ),
            ),
        ],
      ),
    );
  }
}
