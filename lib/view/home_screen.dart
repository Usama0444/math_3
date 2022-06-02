import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_3/main.dart';
import 'package:math_3/view/about_us.dart';
import 'package:math_3/view/components/privacydialog.dart';
import 'package:math_3/view/index_page.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _visible = false, progrerssbar = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () {
      setState(() {
        _visible = true;
        progrerssbar = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
            fontSize: width * 0.06,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
            wordSpacing: 4),
        title: Center(child: Text("OPEN EDUCATIONAL FORUM")),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/b.jpg"), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.cyan,
                        width: 3.0,
                        style: BorderStyle.solid),
                  ),
                ),
                width: width,
                height: height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _txt("Class III/3", FontWeight.bold, width * 0.13),
                    _txt("Mathematics", FontWeight.bold, width * 0.13),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    _txt("TextBook", FontWeight.normal, width * 0.07),
                    _txt("Punjab Textbook Board (PTB)", FontWeight.normal,
                        width * 0.06),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      IndexPage(title: 'Math 3 Textbook'),
                                ));
                          },
                          child: Column(
                            children: [
                              Visibility(
                                child: SizedBox(
                                  width: width * 0.2,
                                  height: height * 0.11,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 10.0),
                                ),
                                visible: progrerssbar,
                              ),
                              Visibility(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 39, 219, 243),
                                            width: 10.0,
                                            style: BorderStyle.solid,
                                          )),
                                      child: Image.asset(
                                        "assets/logo.png",
                                        width: width * 0.2,
                                        height: height * 0.1,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                                visible: _visible,
                              ),
                              _txt("Open Book", FontWeight.bold, width * 0.05)
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height > 900 ? height * 0.18 : height * 0.12,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: width * 0.3),
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              print(height);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => AboutUs()));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Color.fromARGB(255, 39, 219, 243),
                                  size: width * 0.1,
                                ),
                                _txt("About us", FontWeight.normal,
                                    width * 0.04),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Share.share(
                                  "https://play.google.com/store/apps/details?id=com.oef.maths.class3");
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Color.fromARGB(255, 39, 219, 243),
                                  size: width * 0.1,
                                ),
                                _txt("Share", FontWeight.normal, width * 0.04),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PrivacyDialog()));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.privacy_tip,
                                  color: Color.fromARGB(255, 39, 219, 243),
                                  size: width * 0.1,
                                ),
                                _txt(
                                    "Privacy", FontWeight.normal, width * 0.04),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _txt(var txt, FontWeight w, size) {
  return Text(
    "$txt",
    style: TextStyle(
      fontSize: size,
      fontWeight: w,
      color: Color.fromARGB(255, 39, 219, 243),
    ),
  );
}
