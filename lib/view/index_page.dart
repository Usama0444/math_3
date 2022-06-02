import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:math_3/main.dart';
import 'package:math_3/view/chapters.dart';
import 'package:math_3/view/components/Downloader.dart';
import 'package:math_3/view/components/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../controllar/strings.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<IndexPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<IndexPage> {
  var pageStartAt = [];

  List<String> chapNameList = [];

  List<String> list = [];
  var specificUrl = [];
  var flag = 0;
  var totalpages = 0;
  String? filename;
  var dataBytes;
  List<String> chpterPage = [];

  @override
  void initState() {
    checkData();
    super.initState();
  }

  checkData() async {
    var permission = Permission.storage;
    if (permission.status != true) {
      permission.request();
    }
    if (!prefs!.containsKey('page-list')) {
      print('there is no data');
    } else {
      chapNameList = prefs!.getStringList('page-list')!.toList();
      print(chapNameList[0]);
    }
  }

  getChapterUrl(var chaptername) async {
    try {
      chapNameList.clear();
      // print("chapter name => $chaptername");
      var result = await Dio().get(
          "http://134.209.33.80/api/Maths3_EM/$chaptername/?all=yes&c=c040a90d55726aa5c25cea64e9238e7d");

      if (result.statusCode == 200) {
        String dir = (await getApplicationDocumentsDirectory()).path;
        for (var v in result.data) {
          downloadImage(v["page_file_path"], dir);
          if (chapNameList.contains(v['name'])) {
            print("already contained");
          } else {
            chapNameList.add(v['name']);
          }

          totalpages++;
        }
        if (chaptername == 'chap_01') {
          await prefs!.setStringList('chap_01', chapNameList);
        } else if (chaptername == 'chap_02') {
          await prefs!.setStringList('chap_02', chapNameList);
        } else if (chaptername == 'chap_03') {
          await prefs!.setStringList('chap_03', chapNameList);
        } else if (chaptername == 'chap_04') {
          await prefs!.setStringList('chap_04', chapNameList);
        } else if (chaptername == 'chap_05') {
          await prefs!.setStringList('chap_05', chapNameList);
        } else if (chaptername == 'chap_06') {
          await prefs!.setStringList('chap_06', chapNameList);
        } else if (chaptername == 'chap_07') {
          await prefs!.setStringList('chap_07', chapNameList);
        } else if (chaptername == 'chap_08') {
          await prefs!.setStringList('chap_08', chapNameList);
        } else if (chaptername == 'chap_09') {
          await prefs!.setStringList('chap_09', chapNameList);
        } else {
          await prefs!.setStringList('chap_10', chapNameList);
        }
        chpterPage = await prefs!.getStringList('$chaptername')!.toList();
        // print("chpterPage  ${chpterPage.length}");
      }
    } catch (e) {
      var scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        const SnackBar(
          content: Text(
            "connection Failed",
          ),
        ),
      );
      print(e.toString());
    }
  }

  var file;
  Future<dynamic> downloadImage(url, dir) async {
    // print("calling download");
    filename = Uri.parse(url).pathSegments.last;
    file = File('$dir/$filename');

    if (file.existsSync()) {
      setState(() {
        flag++;
        print("already exist $flag");
      });
      var image = await file.readAsBytes();
      return image;
    } else {
      flag = -1;
      print("------downloading------");
      var request = await http.get(Uri.parse(url));
      var bytes = await request.bodyBytes;
      await file.writeAsBytes(bytes);
      return bytes;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: size.width * 0.07),
        titleTextStyle:
            TextStyle(fontSize: size.width * 0.06, fontWeight: FontWeight.bold),
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Column(
              children: const [
                Icon(
                  Icons.restart_alt_rounded,
                  color: Colors.white,
                ),
                Text(
                  "Resume",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  flag = 0;
                  totalpages = 0;
                  chpterPage.clear();
                  if (AllStrings().Chapter[index] == "Numbers") {
                    getChapterUrl("chap_01");
                  } else if (AllStrings().Chapter[index] == "Addition") {
                    getChapterUrl("chap_02");
                  } else if (AllStrings().Chapter[index] == "Subtraction") {
                    getChapterUrl("chap_03");
                  } else if (AllStrings().Chapter[index] ==
                      "Repeating Addition & Multiplication") {
                    getChapterUrl("chap_04");
                  } else if (AllStrings().Chapter[index] ==
                      "Repeated Subtraction & Division") {
                    getChapterUrl("chap_05");
                  } else if (AllStrings().Chapter[index] ==
                      "Measuring Length") {
                    getChapterUrl("chap_06");
                  } else if (AllStrings().Chapter[index] == "Fraction") {
                    getChapterUrl("chap_07");
                  } else if (AllStrings().Chapter[index] == "Time") {
                    getChapterUrl("chap_08");
                  } else if (AllStrings().Chapter[index] == "Shape") {
                    getChapterUrl("chap_09");
                  } else {
                    getChapterUrl("chap_10");
                  }
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext _context) {
                      context = _context;
                      return _Dialog(context);
                    },
                  );

                  Timer(Duration(seconds: 5), () {
                    print("Downloader.flag ${flag} totalpages $totalpages");
                    Navigator.pop(context);

                    // if (flag == totalpages && totalpages != 0) {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => ChaptersPage(
                    //               chptName: AllStrings().Chapter[index],
                    //               pageNo: AllStrings().chapterStartIndex[index],
                    //               ChptPage: chpterPage,
                    //             )));
                    //   }
                    //   if (flag == -1) {
                    //     showDialog(
                    //       context: context,
                    //       barrierDismissible: false,
                    //       builder: (BuildContext _context) {
                    //         context = _context;
                    //         return Dialog(child: Downloader());
                    //       },
                    //     );
                    //     Timer(Duration(seconds: 6), () {
                    //       Navigator.pop(context);
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (_) => ChaptersPage(
                    //                     chptName: AllStrings().Chapter[index],
                    //                     pageNo:
                    //                         AllStrings().chapterStartIndex[index],
                    //                     ChptPage: chpterPage,
                    //                   )));
                    //     });
                    //   }
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(
                        AllStrings().count[index],
                        width: size.width * 0.18,
                        height: size.height * 0.09,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.cyan,
                                      width: 1.0,
                                      style: BorderStyle.solid))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Custom_Text(txt: AllStrings().Chapter[index]),
                                totalPage(context,
                                    AllStrings().chapterStartIndex[index]),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

Widget _downloadertxt(BuildContext context, var txt) {
  var height = MediaQuery.of(context).size.height;
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.6,
    child: Text(
      '''$txt''',
      style: TextStyle(
        fontSize: height > 800 ? 19.0 : 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

Widget totalPage(BuildContext context, var txt) {
  var height = MediaQuery.of(context).size.height;
  return Text(
    "$txt",
    style: TextStyle(
        fontSize: height > 930 ? 24.0 : 18.0,
        color: Colors.black,
        fontWeight: FontWeight.bold),
  );
}

Widget _Dialog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularProgressIndicator(),
          Text("Loading Please wait..\nChecking for available files")
        ],
      ),
    ),
  );
}
