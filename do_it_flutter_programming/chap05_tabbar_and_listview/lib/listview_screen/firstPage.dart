import 'package:flutter/material.dart';

import 'animalItem.dart';

class FirstApp extends StatelessWidget {
  final List<Animal>? list;

  const FirstApp({
    required this.list,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(itemBuilder: (context, position) {
            return GestureDetector(
              child: Card(
                child: Row (
                  children: [
                    Image.asset(
                      list![position].imagePath!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    Text(list![position].animalName!)
                  ],
                ),
              ),
              /// 한 번 터치시 모달 띄워주기
              onTap: () {
                AlertDialog dialog = AlertDialog(
                  content: Text(
                    '이 동물은 ${list![position].kind}입니다.',
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) => dialog
                );
              },
            );
          },
            /// 아이템 개수만큼만 스크롤할 수 있도록 제한한다.
            itemCount: list!.length,
          ),
        ),
      ),
    );
  }
}
