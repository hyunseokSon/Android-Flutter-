import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoFunctionClass extends StatefulWidget {

  const CupertinoFunctionClass({
    super.key});

  @override
  State<CupertinoFunctionClass> createState() => _CupertinoFunctionClassState();
}

class _CupertinoFunctionClassState extends State<CupertinoFunctionClass> {
  double _value = 1;
  FixedExtentScrollController? firstController;

  @override
  void initState() {
    super.initState();
    firstController = FixedExtentScrollController(initialItem: 0);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            child: Icon(Icons.arrow_back_ios),
            onPressed: (){},
          ),
          middle: Text(
            '쿠퍼티노 위젯의 여러 기능들',
          ),
          trailing: CupertinoButton(
            child: Icon(Icons.exit_to_app),
            onPressed: (){},
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CupertinoActivityIndicator, 로딩 표시기
                CupertinoActivityIndicator(
                  radius: 20,
                ),
                // CupertinoButton, 쿠퍼티노 버튼
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CupertinoButton(
                    onPressed: () {},
                    child: Text('Button'),
                    color: Colors.blue,
                  ),
                ),
                // CupertinoAlertDialog - 알림 창
                CupertinoButton(
                  child: Text('쿠퍼티노 dialog'),
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Cupertino 알림창'),
                            content: Text('Cupertino 스타일의 다이얼로그입니다.'),
                            actions: [
                              CupertinoButton(
                                child: Text('확인'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoButton(
                                child: Text('거절'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
                // CupertinoActionSheet - 액션 시트
                CupertinoButton(
                  child: Text('액션 시트 사용해보기'),
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: Text('액션시트 테스트'),
                            message: Text('좋아하는 색은'),
                            actions: [
                              CupertinoButton(
                                child: Text('빨강'),
                                onPressed: () {},
                              ),
                              CupertinoButton(
                                child: Text('파랑'),
                                onPressed: () {},
                              ),
                              CupertinoButton(
                                child: Text('노랑'),
                                onPressed: () {},
                              ),
                            ],
                            cancelButton: CupertinoButton(
                              child: Text('취소'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        });
                  },
                ),
                // CupertinoPicker - 피커
                CupertinoButton(
                  child: Text('CupertinoPicker 사용해보기'),
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context, builder: (context) {
                          return Container(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: CupertinoPicker(
                                    itemExtent: 50,
                                    backgroundColor: Colors.white,
                                    scrollController: firstController,
                                    onSelectedItemChanged: (index) {},
                                    children:
                                      List<Widget>.generate(10, (index) {
                                        return Center(
                                          child: TextButton(
                                            child: Text((++index).toString()),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        );
                                      }),
                                  ),
                                ),
                                TextButton(
                                  child: Text('취소'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                    });
                  },
                ),
                // CupertinoSlider - 슬라이더
                CupertinoSlider(
                  value: _value,
                  onChanged: (index) {
                    setState(() {
                      _value = index;
                    });
                  },
                  max: 100,
                  min: 1,
                ),
                Text(
                  // 소수 둘째 자리까지 표현
                  'Slider 값 : ${_value.toStringAsFixed(2)}'
                ),
              ],
            ),
          ),
        ));
  }
}
