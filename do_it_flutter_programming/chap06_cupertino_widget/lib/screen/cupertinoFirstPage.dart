import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'animalItem.dart';

class CupertinoFirstPage extends StatelessWidget {
  final List<Animal> animalList;

  const CupertinoFirstPage({required this.animalList, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '동물 리스트',
        ),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(15),
            height: 100,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      animalList[index].imagePath!,
                      fit: BoxFit.contain,
                      width: 60,
                      height: 60,
                    ),
                    Text(animalList[index].animalName!),
                  ],
                ),
                Container(
                  height: 2,
                  color: CupertinoColors.black,
                ),
              ],
            ),
          );
        },
        itemCount: animalList.length,
      ),
    );
  }
}
