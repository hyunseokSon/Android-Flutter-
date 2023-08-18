import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:section23_dusty_dust/component/main_app_bar.dart';
import 'package:section23_dusty_dust/component/main_drawer.dart';
import 'package:section23_dusty_dust/repository/stat_repository.dart';
import '../const/regions.dart';
import '../model/stat_model.dart';
import '../utils/data_utils.dart';
import 'hive_category_card.dart';
import 'hive_hourly_card.dart';

class HiveHomeScreen extends StatefulWidget {
  const HiveHomeScreen({super.key});

  @override
  State<HiveHomeScreen> createState() => _HiveHomeScreenState();
}

class _HiveHomeScreenState extends State<HiveHomeScreen> {
  /// 지역 상태 관리
  String region = regions[0];

  // appBar 글씨 여부 판단하기
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // ScrollController 등록
    scrollController.addListener(scrollListener);

    // 데이터 최신화
    fetchData();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();

    super.dispose();
  }

  // Data 받아오는 함수 생성
  Future<void> fetchData() async {
    try {
      final now = DateTime.now();
      // 내가 가져오는 시간의 기준
      final fetchTime = DateTime(now.year, now.month, now.day, now.hour);

      final box = Hive.box<StatModel>(ItemCode.PM10.name);

      // 기존에 했던 작업이면 반복적으로 실행되는 것을 막도록 한다.
      // 똑같은 DataTime이라면 true를 돌려받는다.

      // box안에 값이 없을 때를 구분해주어야 한다.
      if (box.values.isNotEmpty &&
          (box.values.last as StatModel).dataTime.isAtSameMomentAs(fetchTime)) {
        print('이미 최신 데이터가 있습니다.');
        return;
      }

      List<Future> futures = [];

      for (ItemCode itemCode in ItemCode.values) {
        futures.add(
          StatRepository.fetchData(
            itemCode: itemCode,
          ),
        );
      }

      // Future들이 끝날때까지 한번에 기다릴 수 있다.
      // 대신 모든 요청이 동시에 나간다.
      final results = await Future.wait(futures);

      // Hive에 데이터 넣기
      for (int i = 0; i < results.length; i++) {
        final key = ItemCode.values[i];
        final value = results[i];

        // 해당하는 키의 box를 반복적으로 연다.
        final box = Hive.box<StatModel>(key.name);

        // 박스 안에 값들 정리, 정렬
        for (StatModel stat in value) {
          box.put(stat.dataTime.toString(), stat);
        }

        final allKeys = box.keys.toList();

        if (allKeys.length > 24) {
          // start - 시작 인덱스
          // end - 끝 인덱스
          // 예 : 리스트 : ['red', 'orange', 'yellow', 'green', 'blue']
          // .sublist(1,3)을 한다면 ?
          // 결과 : 리스트 : ['orange', 'yellow']

          // 24개의 결과만 남긴다.
          final deleteKeys = allKeys.sublist(0, allKeys.length - 24);
          box.deleteAll(deleteKeys);
        }
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('인터넷 연결이 원활하지 않습니다.'),
        ),
      );
    }
  }

  // 스크롤 리스너
  scrollListener() {
    // offset을 통해 현재 스크롤 위치를 알 수 있다.
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;

    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        // 만약 box에 아무 값도 안들어있다면...
        if (box.values.isEmpty) {
          // 아래와 같이 하면 검은색으로 코드가 발생, 싫다면 Scaffold로 바꾸기
          return Center(
            child: CircularProgressIndicator(),
          );

          // return Scaffold(
          //   body: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
        }

        // 현재 box 알기
        // PM10 (미세먼지)
        // box.value.toList().last
        // 가장 최근 값을 알기 위해서는 first가 아닌 last를 써주어야 한다.
        final recentStat = (box.values.toList().last as StatModel);

        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: recentStat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );

        return Scaffold(
          drawer: MainDrawer(
            darkColor: status.darkColor,
            lightColor: status.lightColor,
            selectedRegion: region,
            onRegionTap: (String region) {
              setState(() {
                this.region = region;
              });

              // 뒤로 가기
              Navigator.of(context).pop();
            },
          ),
          body: Container(
            color: status.primaryColor,
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchData();
              },
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  MainAppBar(
                    region: region,
                    stat: recentStat,
                    status: status,
                    dateTime: recentStat.dataTime,
                    isExpanded: isExpanded,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HiveCategoryCard(
                          region: region,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ...ItemCode.values.map(
                          (itemCode) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: HiveHourlyCard(
                                darkColor: status.darkColor,
                                lightColor: status.lightColor,
                                itemCode: itemCode,
                                region: region,
                              ),
                            );
                          },
                        ).toList(),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
