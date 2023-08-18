import 'package:flutter/material.dart';
import 'package:section23_dusty_dust/utils/data_utils.dart';

import '../model/stat_model.dart';
import 'card_title.dart';
import 'main_card.dart';

class HourlyCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final String category;
  final List<StatModel> stats;
  final String region;

  const HourlyCard({required this.category,
    required this.darkColor,
    required this.lightColor,
    required this.stats,
    required this.region,
    super.key});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간별 $category',
            backgroundColor: darkColor,
          ),
          Column(
            children: stats.map(
                (stat) => renderRow(stat: stat),
            ).toList(),
            // children: List.generate(24, (index) {
            //   // 현재 시간
            //   final now = DateTime.now();
            //   final hour = now.hour;
            //   int currentHour = hour - index;
            //
            //   // 3 2 1 0 -1
            //   if (currentHour < 0) {
            //     currentHour += 24;
            //   }
            //
            //   return
            // }),
          ),
        ],
      ),
    );
  }

  Widget renderRow({required StatModel stat}) {
    final status = DataUtils
        .getStatusFromItemCodeAndValue(
      value: stat.getLevelFromRegion(region),
      itemCode: stat.itemCode,
    );

    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${stat.dataTime.hour}시',
            ),
          ),
          Expanded(
            child: Image.asset(
              status.imagePath,
              height: 20.0,
            ),
          ),
          Expanded(
            child: Text(
              status.label,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
