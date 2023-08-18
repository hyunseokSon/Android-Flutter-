import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../model/stat_and_status_model.dart';
import '../utils/data_utils.dart';
import 'card_title.dart';
import 'main_card.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;
  final List<StatAndStatusModel> models;

  const CategoryCard(
      {required this.darkColor,
      required this.region,
      required this.models,
      required this.lightColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          // constraint.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                backgroundColor: darkColor,
                title: '종류별 통계',
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: models
                      .map(
                        (model) => MainStat(
                          category: DataUtils.getItemCodeKrString(
                            itemCode: model.itemCode,
                          ),
                          imgPath: model.status.imagePath,
                          level: model.status.label,
                          stat: '${model.stat.getLevelFromRegion(
                            region,
                          )}${DataUtils.getUnitFromItemCode(
                            itemCode: model.itemCode,
                          )}',
                          width: constraint.maxWidth / 3,
                        ),
                      )
                      .toList(),
                  // children: List.generate(
                  //   20,
                  //   (index) => MainStat(
                  //     width: constraint.maxWidth / 3,
                  //       category: '미세먼지$index',
                  //       imgPath: 'asset/img/best.png',
                  //       level: '최고',
                  //       stat: '0㎛'),
                  // ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
