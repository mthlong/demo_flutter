import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        ..._buildOverlayBackground(
            widthScreen: widthScreen, heightScreen: heightScreen),
        _buildIconSwift(widthScreen: widthScreen, heightScreen: heightScreen)
      ],
    );
  }

  List<Widget> _buildOverlayBackground(
      {required double widthScreen, required double heightScreen}) {
    double positionTopBackground = heightScreen * .24;
    double positionLefBackground = widthScreen * .1;
    double sizeRedCircle = widthScreen * .45;
    double sizeBlueCircle = widthScreen / 4;
    double spaceBetweenCircle = widthScreen * .1;
    double blurValue = 100;
    Widget background = Container(
      color: Colors.white,
    );
    Widget twoCircle = Positioned(
        top: positionTopBackground,
        left: positionLefBackground,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomPaint(
              size: Size(sizeRedCircle, sizeRedCircle),
              painter: CircleBlurPainter(
                  color: const Color(0xfff18283), blurSigma: blurValue),
            ),
            SizedBox(
              width: spaceBetweenCircle,
            ),
            CustomPaint(
              size: Size(sizeBlueCircle, sizeBlueCircle),
              painter: CircleBlurPainter(
                  color: const Color(0xffb3d3f4), blurSigma: blurValue),
            ),
          ],
        ));
    return [background, twoCircle];
  }

  Widget _buildIconSwift(
      {required double widthScreen, required double heightScreen}) {
    double widthImage = widthScreen * .56;
    double heightImage = heightScreen * .23;
    double positionTopImage = heightScreen * .1;
    double positionLeftImage = widthScreen * .27;
    return Positioned(
      top: positionTopImage,
      left: positionLeftImage,
      child: SvgPicture.asset(
        'assets/swift_icon.svg',
        width: widthImage,
        height: heightImage,
      ),
    );
  }
}

class CircleBlurPainter extends CustomPainter {
  CircleBlurPainter({required this.blurSigma, required this.color});

  double blurSigma;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
