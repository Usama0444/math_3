import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class WriteOnScreen extends StatefulWidget {
  var pageNo;
  WriteOnScreen({Key? key, required this.pageNo}) : super(key: key);

  @override
  State<WriteOnScreen> createState() => _WriteOnScreenState();
}

class _WriteOnScreenState extends State<WriteOnScreen> {
  List<Offset> points = <Offset>[];
  CarouselController controller = CarouselController();
  var path;
  GlobalKey globalKey = GlobalKey();

  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.black;
  void initState() {
    getData();
    super.initState();
  }

  List<String> list = [];
  Future<void> getData() async {
    try {
      var result = await Dio().get(
          "http://134.209.33.80/api/Maths3_EM/?all=yes&c=c040a90d55726aa5c25cea64e9238e7d");
      if (result.statusCode == 200) {
        for (var v in result.data) {
          list.add(v["page_file_path"]);
          setState(() {});
        }
      }

      setState(() {
        print("${list[widget.pageNo]}");
        path = list[widget.pageNo];
      });
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      print(e.toString());
    }
  }

  var isDownload = false;

  Future DownloadImage() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
  }

  Future<void> _pickStroke() async {
    //Shows AlertDialog
    return showDialog<void>(
      context: context,

      //Dismiss alert dialog when set true
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        //Clips its child in a oval shape
        return ClipOval(
          child: AlertDialog(
            //Creates three buttons to pick stroke value.
            actions: <Widget>[
              //Resetting to default stroke value
              FlatButton(
                child: Icon(
                  Icons.clear,
                ),
                onPressed: () {
                  strokeWidth = 3.0;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Icon(
                  Icons.brush,
                  size: 24,
                ),
                onPressed: () {
                  strokeWidth = 10.0;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Icon(
                  Icons.brush,
                  size: 40,
                ),
                onPressed: () {
                  strokeWidth = 30.0;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Icon(
                  Icons.brush,
                  size: 60,
                ),
                onPressed: () {
                  strokeWidth = 50.0;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _opacity() async {
    //Shows AlertDialog
    return showDialog<void>(
      context: context,

      //Dismiss alert dialog when set true
      barrierDismissible: true,

      builder: (BuildContext context) {
        //Clips its child in a oval shape
        return ClipOval(
          child: AlertDialog(
            //Creates three buttons to pick opacity value.
            actions: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.opacity,
                  size: 24,
                ),
                onPressed: () {
                  //most transparent
                  opacity = 0.1;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Icon(
                  Icons.opacity,
                  size: 40,
                ),
                onPressed: () {
                  opacity = 0.5;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Icon(
                  Icons.opacity,
                  size: 60,
                ),
                onPressed: () {
                  //not transparent at all.
                  opacity = 1.0;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _save() async {
    RenderRepaintBoundary? boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    //Request permissions if not already granted
    if (!(await Permission.storage.status.isGranted))
      await Permission.storage.request();

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 60,
        name: "canvas_image");
    print(result);
  }

  List<Widget> fabOption() {
    return <Widget>[
      FloatingActionButton(
        heroTag: "paint_stroke",
        child: Icon(Icons.brush),
        tooltip: 'Stroke',
        onPressed: () {
          //min: 0, max: 50
          setState(() {
            _pickStroke();
          });
        },
      ),
      FloatingActionButton(
          heroTag: "erase",
          child: Icon(Icons.clear),
          tooltip: "Erase",
          onPressed: () {
            setState(() {
              points.clear();
            });
          }),
      FloatingActionButton(
        backgroundColor: Colors.white,
        heroTag: "color_green",
        child: colorMenuItem(Colors.green),
        tooltip: 'Color',
        onPressed: () {
          setState(() {
            selectedColor = Colors.green;
          });
        },
      ),
    ];
  }

  Widget colorMenuItem(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.07),
        backgroundColor: Color.fromARGB(255, 39, 219, 243),
        titleTextStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold),
        title: Text(
          '''Maths 3 Textbook''',
          maxLines: 2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              children: [
                Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          )
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox? object = context.findRenderObject() as RenderBox?;
            Offset _localPosition =
                object!.globalToLocal(details.globalPosition);
            points = List.from(points)..add(_localPosition);
          });
        },
        onPanEnd: (DragEndDetails details) => points != null,
        child: RepaintBoundary(
          child: Stack(
            children: <Widget>[
              Center(
                  child: Image.file(
                File(
                    "/data/user/0/com.example.math_3/app_flutter/Math_3_PTB_EM_Page_003.webp"),
                fit: BoxFit.fill,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
              )),
              CustomPaint(
                size: Size.infinite,
                painter: Writing(points: points),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: AnimatedFloatingActionButton(
      //   fabButtons: fabOption(),
      //   colorStartAnimation: Colors.blue,
      //   colorEndAnimation: Colors.red,
      //   animatedIconData: AnimatedIcons.menu_close,
      // ),
    );
  }
}

class Writing extends CustomPainter {
  List<Offset>? points;
  Writing({this.points});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (int i = 0; i < points!.length - 1; i++) {
      if (points![i] != null && points![i + 1] != null) {
        canvas.drawLine(points![i], points![i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Writing oldDelegate) => oldDelegate.points != points;
}

//Class to define a point touched at canvas
class TouchPoints {
  Paint paint;
  Offset points;
  TouchPoints({required this.points, required this.paint});
}
