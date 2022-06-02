import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_3/controllar/strings.dart';
import 'package:math_3/main.dart';
import 'package:math_3/view/components/privacydialog.dart';
import 'package:share_plus/share_plus.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _HomePageState();
}

class _HomePageState extends State<AboutUs> {
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
        iconTheme: IconThemeData(
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.07),
        titleTextStyle: TextStyle(
          fontSize: height > 930 ? width * 0.055 : width * 0.048,
        ),
        title: Center(child: Text("About Open Educational Forum")),
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
                child: ListView(
                  padding: EdgeInsets.only(top: 30),
                  children: [
                    Center(
                      child: SizedBox(
                        width: width * 0.9,
                        child: _txt(AllStrings().about, FontWeight.normal,
                            height > 930 ? 28.0 : 18.0),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.12),
                      child: _txt("Version : V7 R1.0.7", FontWeight.normal,
                          height > 930 ? 30.0 : 25.0),
                    ),
                    InkWell(
                      onTap: () {
                        Share.share(
                            "https://play.google.com/store/apps/details?id=com.oef.maths.class3");
                      },
                      child: _Components(context, Icons.share, "Share App"),
                    ),
                    InkWell(
                      onTap: () {
                        // showDialog(
                        //     context: context, builder: (_) => _dialog(context));
                      },
                      child: _Components(
                          context, Icons.thumb_up_alt_outlined, "Rate Us"),
                    ),
                    InkWell(
                      onTap: () {},
                      child: _Components(context, Icons.apps, "More Apps"),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context, builder: (_) => PrivacyDialog());
                      },
                      child: _Components(
                          context, Icons.privacy_tip, "Privacy Policy"),
                    ),
                    InkWell(
                      onTap: () {
                        // showDialog(
                        //     context: context, builder: (_) => _dialog(context));
                      },
                      child: _Components(
                          context, Icons.feedback_outlined, "Feedback"),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
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
    textAlign: TextAlign.justify,
    style: TextStyle(
      fontSize: size,
      fontWeight: w,
      color: Color.fromARGB(255, 9, 214, 241),
    ),
  );
}

Widget _Components(BuildContext context, IconData icon, txt) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return Container(
    margin: EdgeInsets.only(left: width * 0.1, top: 20.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
                // Icons.privacy_tip,
                icon,
                size: width * 0.07,
                color: Color.fromARGB(255, 9, 214, 241)),
            Container(
              width: width * 0.6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _txt(
                    txt,
                    // "Privacy Policy",
                    FontWeight.normal,
                    height > 930 ? 24.0 : 20.0),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid))),
            )
          ],
        )
      ],
    ),
  );
}
