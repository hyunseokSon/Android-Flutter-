import 'package:flutter/material.dart';
import 'package:section23_dusty_dust/const/colors.dart';

import '../const/regions.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;
  final Color darkColor;
  final Color lightColor;

  const MainDrawer({
    required this.onRegionTap,
    required this.selectedRegion,
    required this.darkColor,
    required this.lightColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          // title 부분을 의미
          DrawerHeader(
              child: Text(
                '지역 선택',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
          ),
          ...regions.map(
              (e) => ListTile(
                tileColor: Colors.white,
                // 선택된 tileColor
                selectedTileColor: lightColor,
                // 선택된 글자색
                selectedColor: Colors.black,
                // true를 넣으면 위 사항이 반영된다.
                selected: e == selectedRegion,
                onTap: (){
                  onRegionTap(e);

                  // 여기에 pop을 해도 가능!
                  // Navigator.of(context).pop();
                },
                title: Text(
                  e,
                ),
              ),
          ).toList(),
        ],
      ),
    );
  }
}
