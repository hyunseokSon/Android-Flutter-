import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<String> todoList = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    todoList.add("당근 사오기");
    todoList.add("약 사오기");
    todoList.add("청소하기");
    todoList.add("부모님께 전화하기");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                child: Text(
                  todoList[index],
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/first_subsub', arguments: todoList[index]);
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNavigation(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/first_sub');
    setState(() {
      todoList.add(result as String);
    });
  }
}
