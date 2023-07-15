import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TestWidget(label: 'test1'),
            const TestWidget(label: 'test2'),
            // ElevatedButton은 클릭 시 어떤 변화가 일어날 지 모르기 때문에
            // const를 붙일 수 없다!
            ElevatedButton(
                onPressed: (){
                  setState(() {

                  });
                },
                child:
                Text(
                  '빌드!',
                )
            )
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String label;

  const TestWidget({
    required this.label,
    super.key});

  @override
  Widget build(BuildContext context) {
    print('$label build 실행!');

    return Container(
      child: Text(
        label,
      ),
    );
  }
}
