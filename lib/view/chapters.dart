import 'dart:async';
import 'dart:io' as io;
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'drawing.dart';

class ChaptersPage extends StatefulWidget {
  var chptName, pageNo;
  List<String> ChptPage = [];
  ChaptersPage(
      {Key? key,
      required this.chptName,
      required this.pageNo,
      required this.ChptPage})
      : super(key: key);

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  var count; //just counter k leya
  CarouselController controller = CarouselController();
  Image? img;
  @override
  void initState() {
    // setState(() {
    count = widget.pageNo;
    // });
    getData();

    super.initState();
  }

  List<String> list = [];

  Future<void> getData() async {
    try {
      String dir = (await getApplicationDocumentsDirectory()).path;
      var size = widget.ChptPage.toList();
      print("list dir $dir");
      for (var v in size) {
        var path = '$dir/${v}webp';
        list.add(path);
      }
      setState(() {});
      // print("list ${list.length}");
      // print("widget.pageNo ${widget.pageNo}");
      controller.jumpToPage(0);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.07),
        backgroundColor: Color.fromARGB(255, 39, 219, 243),
        titleTextStyle: TextStyle(
            fontSize: height > 930 ? 25.0 : 16.95, fontWeight: FontWeight.bold),
        title: Text(
          '''${widget.chptName}''',
          maxLines: 2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0, top: 7.0, bottom: 7.0),
            child: Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                      style: BorderStyle.solid),
                  shape: BoxShape.circle),
              child: Center(
                child: Text(
                  "$count",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              children: const [
                Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                Text(
                  "Share",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          final double width = MediaQuery.of(context).size.width;
          return CarouselSlider(
            //this is
            carouselController: controller,
            options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    print("$index==${widget.pageNo}");
                    count = index + 1;
                    // widget.pageNo += 1;
                  });
                }),
            items: list.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: 60, top: 10),
                child: Center(
                    child: Image.file(
                  io.File(item),
                  fit: BoxFit.fill,
                  height: height,
                  width: width,
                )),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.cyan,
                            width: 1.0,
                            style: BorderStyle.solid))),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => WriteOnScreen(
                        pageNo: widget.pageNo,
                      )));
        },
        child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                shape: BoxShape.circle,
                color: Colors.cyan,
              ),
              child: const Icon(
                Icons.edit_note_outlined,
                size: 70,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
