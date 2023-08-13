import 'package:flutter/material.dart';

class FirstSubScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  FirstSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('두 번째 페이지'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                '할 일을 저장하세요.',
              ),
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(controller.value.text);
                },
                child: Text(
                  '저장하기',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
