import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NetworkToLocalImage {
  List url = [];
  var flag = 0;
  String? filename;
  var dataBytes;
  NetworkToLocalImage(this.url);

  void GiveUrl() {
    for (var v in url) {
      GetIImagePath(v);
    }
  }

  GetIImagePath(url) {
    filename = Uri.parse(url).pathSegments.last;
    downloadImage(url).then((bytes) {
      dataBytes = bytes;
    });
  }

  Future<dynamic> downloadImage(url) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    if (file.existsSync()) {
      flag++;
      // print('file already exist $flag');
      var image = await file.readAsBytes();

      return image;
    } else {
      print('file not found downloading from server $flag');
      var request = await http.get(Uri.parse(url));
      var bytes = await request.bodyBytes;
      await file.writeAsBytes(bytes);
      return bytes;
    }
  }
}
