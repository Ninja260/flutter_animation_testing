import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

const double _squareWidth = 200;

class _CircleClipper extends CustomClipper<Path> {
  const _CircleClipper();

  @override
  Path getClip(Size size) {
    var path = Path();

    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Color getRandomColor() => Color(0xFF000000 + math.Random().nextInt(0x00FFFFFF));

class ColorCirclePage extends StatefulWidget {
  const ColorCirclePage({super.key});

  static const String route = '/color-circle';

  @override
  State<ColorCirclePage> createState() => _ColorCirclePageState();
}

class _ColorCirclePageState extends State<ColorCirclePage> {
  Color _color1 = getRandomColor();

  Color _color2 = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: const _CircleClipper(),
          child: TweenAnimationBuilder(
            tween: ColorTween(
              begin: _color1,
              end: _color2,
            ),
            onEnd: () {
              setState(() {
                _color1 = _color2;
                _color2 = getRandomColor();
              });
            },
            duration: const Duration(seconds: 1),
            builder: (context, color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color!,
                  BlendMode.srcATop,
                ),
                child: child,
              );
            },
            child: Container(
              width: _squareWidth,
              height: _squareWidth,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
