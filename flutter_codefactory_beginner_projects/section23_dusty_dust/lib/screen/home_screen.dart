import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:section23_dusty_dust/component/hourly_card.dart';
import 'package:section23_dusty_dust/component/main_app_bar.dart';
import 'package:section23_dusty_dust/component/main_drawer.dart';
import 'package:section23_dusty_dust/component/main_stat.dart';
import 'package:section23_dusty_dust/const/colors.dart';
import 'package:section23_dusty_dust/const/data.dart';
import 'package:section23_dusty_dust/model/stat_and_status_model.dart';
import 'package:section23_dusty_dust/repository/stat_repository.dart';

import '../component/card_title.dart';
import '../component/category_card.dart';
import '../component/main_card.dart';
import '../const/regions.dart';
import '../const/status_level.dart';
import '../model/stat_model.dart';
import '../utils/data_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// 지역 상태 관리
  String region = regions[0];
  // appBar 글씨 여부 판단하기
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // fetchData();

    // ScrollController 등록
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();

    super.dispose();
  }

  // Data 받아오는 함수 생성
  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

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

    for (int i = 0; i < results.length; i++) {
      // ItemCode
      final key = ItemCode.values[i];
      // List<StatModel>
      final value = results[i];

      stats.addAll({
        key: value,
      });
    }

    return stats;
    // print(statModels);
    // return statModels;
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
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('에러가 있습니다.'),
              ),
            );
          }

          if (!snapshot.hasData) {
            // 로딩 상태
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // 데이터가 있는 상태
          // 미세먼지에 해당되는 통계들을 모두 가져온다.
          Map<ItemCode, List<StatModel>> stats = snapshot.data!;
          StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

          // 1 - 5, 6 - 10, 11 - 15 까지의 구간이 있을 때
          // 미세먼지를 기준으로만 상태를 가져온다.
          // 미세먼지 최근 데이터의 현재 상태
          final status = DataUtils.getStatusFromItemCodeAndValue(
            value: pm10RecentStat.seoul,
            itemCode: ItemCode.PM10,
          );

          // print(pm10RecentStat.seoul);

          // itemCode들을 모두 가져온다.
          final ssModel = stats.keys.map((key) {
            // 필터링해서 status 값 찾기
            final value = stats[key]!;
            final stat = value[0];

            return StatAndStatusModel(
              itemCode: key,
              status: DataUtils.getStatusFromItemCodeAndValue(
                value: stat.getLevelFromRegion(region),
                itemCode: key,
              ),
              stat: stat,
            );
          }).toList();

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
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    MainAppBar(
                      region: region,
                      stat: pm10RecentStat,
                      status: status,
                      dateTime: pm10RecentStat.dataTime,
                      isExpanded: isExpanded,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CategoryCard(
                            region: region,
                            models: ssModel,
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ...stats.keys.map(
                                (itemCode) {
                              final stat = stats[itemCode]!;

                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0),
                                child: HourlyCard(
                                  darkColor: status.darkColor,
                                  lightColor: status.lightColor,
                                  category: DataUtils.getItemCodeKrString(
                                    itemCode: itemCode,
                                  ),
                                  stats: stat,
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
          );
        });
  }
}
