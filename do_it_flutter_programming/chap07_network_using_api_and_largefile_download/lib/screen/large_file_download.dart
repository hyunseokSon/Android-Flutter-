import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargeFileDownload extends StatefulWidget {
  const LargeFileDownload({super.key});

  @override
  State<LargeFileDownload> createState() => _LargeFileDownloadState();
}

class _LargeFileDownloadState extends State<LargeFileDownload> {
  final imgUrl =
      'http://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
      '?auto=compress';

  bool isDownloading = false;
  var progressString = "";
  String file = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Large File Example'),
      ),
      body: Center(
        child: isDownloading
            ? _downloadingTrue(
          progressString: progressString,
        )
            : _downloadFalse(
          file: file,
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },

        child: Icon(
          Icons.file_download,
        ),
      ),
    );
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(imgUrl, '${dir.path}/myimage.jpg',
          onReceiveProgress: (rec, total) {
        print('Rec :  $rec, Total: $total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          isDownloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(1) + '%';
        });
      });
    } catch (e) {
      print(e);
    }

    // 다운로드가 완료된 이후
    setState(() {
      isDownloading = false;
      progressString = 'Completed';
    });

    print('Download Completed!!');
  }

}

class _downloadingTrue extends StatelessWidget {
  final progressString;
  const _downloadingTrue({
    required this.progressString,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      width: 200.0,
      child: Card (
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20,),
            Text(
              'Downloading File : $progressString',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _downloadFalse extends StatelessWidget {
  final String file;
  const _downloadFalse({
    required this.file,
    super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: downloadWidget(file),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            print('none');
            return Text('데이터 없음');
          case ConnectionState.waiting:
            print('waiting...');
            return CircularProgressIndicator();
          case ConnectionState.active:
            print('active!');
            return CircularProgressIndicator();
          case ConnectionState.done:
            print('done...');
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            }
        }

        print('end process..!');
        return Text('데이터 없음 ..');
      },
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict(); // 캐시 초기화하기

    if(exist) {
      return Center(
        child: Column(
          children: [
            Image.file(
              File(filePath),
            )
          ],
        ),
      );
    }

    else {
      return Text('No data..');
    }
  }
}


