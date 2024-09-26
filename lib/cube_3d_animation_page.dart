import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Cube3DAnimationPage extends StatefulWidget {
  const Cube3DAnimationPage({super.key});

  static const String route = '/cube-3d-animation';

  @override
  State<Cube3DAnimationPage> createState() => _Cube3DAnimationPageState();
}

const double widthAndHeight = 100;

class _Cube3DAnimationPageState extends State<Cube3DAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Listenable _animationChangeNotifier;

  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 20,
      ),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 30,
      ),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 40,
      ),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    );

    _animationChangeNotifier = Listenable.merge([
      _xController,
      _yController,
      _zController,
    ]);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: widthAndHeight,
            width: double.infinity,
          ),
          AnimatedBuilder(
            animation: _animationChangeNotifier,
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_animation.evaluate(_xController))
                  ..rotateY(_animation.evaluate(_yController))
                  ..rotateZ(_animation.evaluate(_zController)),
                child: Stack(
                  children: [
                    // back
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(
                          Vector3(0, 0, -widthAndHeight),
                        ),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.purple,
                      ),
                    ),
                    // left hand side
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.red,
                      ),
                    ),
                    // right hand side
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.blue,
                      ),
                    ),
                    // front
                    Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: Colors.green,
                    ),
                    // bottom
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.brown,
                      ),
                    ),
                    // top
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
