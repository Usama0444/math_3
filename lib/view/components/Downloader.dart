import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class Downloader extends StatefulWidget {
  const Downloader({Key? key}) : super(key: key);

  @override
  State<Downloader> createState() => _testingState();
}

class _testingState extends State<Downloader> {
  var initail = 0.0;
  var persentage = 0;
  void update() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      initail = initail + 0.01;
      if (persentage != 100) {
        persentage = persentage + 1;
      }

      if (this.mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    update();
    return Container(
      width: double.infinity,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _downloadertxt(context, "Download in progress!", FontWeight.bold),
          _downloadertxt(
              context,
              "Textbook data is downloading for the first time only.",
              FontWeight.normal),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: initail,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("$persentage%"), Text("${persentage}/100")],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _downloadertxt(BuildContext context, var txt, FontWeight font) {
  var height = MediaQuery.of(context).size.height;
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        '''$txt''',
        style: TextStyle(
          fontSize: height > 800 ? 23.0 : 16.0,
          fontWeight: font,
          color: Colors.black,
        ),
      ),
    ),
  );
}
