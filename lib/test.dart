import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final imgUrl =
    "http:\/\/134.209.33.80\/pages\/Maths3_EM\/chap_01\/Math_3_PTB_EM_Page_016.webp";
Dio dio = Dio();

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  int _counter = 0;
  var isdoenload = false;
  var image;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );
      File file = File(savePath);
      file.writeAsBytes(response.data);
      convert(response.data);
    } catch (e) {
      print(e);
    }
  }

  void convert(bytes) {
    image = Image.memory(bytes);
    setState(() {
      isdoenload = true;
    });
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
                onPressed: () async {
                  var tempDir = await getTemporaryDirectory();
                  String fullPath = tempDir.path + "/boo2.pdf'";
                  print('full path ${fullPath}');

                  download2(dio, imgUrl, fullPath);
                },
                icon: Icon(
                  Icons.file_download,
                  color: Colors.white,
                ),
                color: Colors.green,
                textColor: Colors.white,
                label: Text('Dowload Invoice')),
            Text(
              'You have pushed the button this many times:',
            ),
            isdoenload == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    child: image,
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
