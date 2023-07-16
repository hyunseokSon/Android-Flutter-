import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버튼'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(

                /// Material State
                // hovered - 호버링 상태 (마우스 커서를 올려놓은 상태)
                // focused - 포커스 됐을때 (텍스트 필드)
                // pressed - 눌렸을 때
                // dragged - 드래그됐을 때
                // selected - 선택됐을 때(체크박스, 라디오 박스)
                // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을 때
                // disabled - 비활성화 됐을 때 (onPressed: null 일 때 )
                // error - 에러 상태(텍스트 필드 - 버튼에서 사용 X)

                backgroundColor: MaterialStateProperty.all(
                  Colors.black,
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if(states.contains(MaterialState.pressed)) {
                        return Colors.white;
                      }
                  return Colors.blue;
                }),
                padding: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if(states.contains(MaterialState.pressed)) {
                        return EdgeInsets.all(100.0);
                      }
                      return EdgeInsets.all(20.0);
                    }
                ),
              ),
              child: Text(
                'ButtonStyle',
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    // 메인 컬러 - 여기서는 배경색을 변경!
                    primary: Colors.red,

                    // 글자 및 애니메이션 색깔 변경!
                    onPrimary: Colors.black,

                    // 그림자 색깔 변경!
                    shadowColor: Colors.green,

                    // 3D 입체감의 높이 (그림자 색깔에 입체감을 부여함)
                    elevation: 10.0,

                    // 텍스트 스타일 지정
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),

                    // 글자 주변에 적용되는 Padding
                    padding: EdgeInsets.all(32.0),

                    // 테두리 속성을 지정한다.
                    side: BorderSide(
                      color: Colors.black,
                      width: 4.0,
                    )),
                child: Text(
                  'ElevatedButton',
                )),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                primary: Colors.green,
                backgroundColor: Colors.yellow,
              ),
              child: Text(
                'OutLinedButton',
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.brown,
                backgroundColor: Colors.blue,
              ),
              child: Text('TextButton'),
            )
          ],
        ),
      ),
    );
  }
}
