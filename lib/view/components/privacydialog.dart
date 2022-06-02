import 'package:flutter/material.dart';

import '../../controllar/strings.dart';

class PrivacyDialog extends StatelessWidget {
  const PrivacyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        width: double.infinity,
        height: height > 930 ? height * 0.75 : height * 0.8,
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 9, 214, 241),
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height > 930 ? 25.0 : 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(14.0),
              height: MediaQuery.of(context).size.height * 0.55,
              child: Text(
                AllStrings().privacyString,
                style: TextStyle(
                    fontSize: height > 930 ? 25.0 : 14.7,
                    color: Colors.grey[600]),
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "PRIVACY POLICY",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height > 930 ? 20.0 : 13.5),
                    )),
                SizedBox(
                  width: height > 930 ? 50.0 : 15.0,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height > 930 ? 20.0 : 13.5),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
