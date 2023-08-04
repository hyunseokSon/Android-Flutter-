import 'package:flutter/material.dart';

class MaterialFlutterApp extends StatefulWidget {
  const MaterialFlutterApp({super.key});

  @override
  State<MaterialFlutterApp> createState() => _MaterialFlutterAppState();
}

class _MaterialFlutterAppState extends State<MaterialFlutterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Material Design App'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(
          Icons.add,
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.android,
              ),
              Text(
                'Android',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
