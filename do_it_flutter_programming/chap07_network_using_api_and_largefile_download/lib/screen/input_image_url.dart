import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class InputImageUrlDownload extends StatefulWidget {
  const InputImageUrlDownload({super.key});

  @override
  State<InputImageUrlDownload> createState() => _InputImageUrlDownloadState();
}

class _InputImageUrlDownloadState extends State<InputImageUrlDownload> {
  TextEditingController? _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(
        text: 'http://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
            '?auto=compress');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Image Url'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'URL입력하여 직접 다운로드하기',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'URL을 입력하세요',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                child: TextField(
                  controller: _editingController,
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w700,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'url을 입력해주세요...',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
