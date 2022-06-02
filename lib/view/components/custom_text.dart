import 'package:flutter/material.dart';

class Custom_Text extends StatelessWidget {
  var txt;
  Custom_Text({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _text(context, this.txt);
  }
}

Widget _text(BuildContext context, var txt) {
  var height = MediaQuery.of(context).size.height;
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.6,
    child: Text(
      '''$txt''',
      style: TextStyle(
        fontSize: height > 930 ? 24.0 : 18.0,
        color: Colors.black,
      ),
    ),
  );
}
