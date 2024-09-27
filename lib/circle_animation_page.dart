import 'dart:math';

import 'package:flutter/material.dart';

class CircleAnimationPage extends StatefulWidget {
  const CircleAnimationPage({super.key});

  static const String route = '/circle-animation';

  @override
  State<CircleAnimationPage> createState() => _CircleAnimationPageState();
}

extension DelayedX on VoidCallback {
  Future<void> delayed(Duration duration) =>
      Future<void>.delayed(duration, this);
}

class _CircleAnimationPageState extends State<CircleAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _counterClockwiseAnimationController;
  late Animation<double> _counterClockwiseRotationAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  late Listenable _changeAnimationNotifier;

  @override
  void initState() {
    super.initState();

    _counterClockwiseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _counterClockwiseRotationAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2),
    ).animate(
      CurvedAnimation(
        parent: _counterClockwiseAnimationController,
        curve: Curves.bounceOut,
      ),
    );

    // flip animation
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.bounceOut,
      ),
    );

    _changeAnimationNotifier = Listenable.merge([
      _counterClockwiseAnimationController,
      _flipController,
    ]);

    // status listener
    _counterClockwiseAnimationController.addStatusListener(
      (status) {
        if (status.isCompleted) {
          _flipAnimation = Tween<double>(
            begin: _flipAnimation.value,
            end: _flipAnimation.value + pi,
          ).animate(
            CurvedAnimation(
              parent: _flipController,
              curve: Curves.bounceOut,
            ),
          );

          // reset the flip controller and start the animation
          _flipController
            ..reset()
            ..forward();
        }
      },
    );

    _flipController.addStatusListener(
      (status) {
        if (status.isCompleted) {
          _counterClockwiseRotationAnimation = Tween<double>(
            begin: _counterClockwiseRotationAnimation.value,
            end: _counterClockwiseRotationAnimation.value + -(pi / 2),
          ).animate(
            CurvedAnimation(
              parent: _counterClockwiseAnimationController,
              curve: Curves.bounceOut,
            ),
          );

          _counterClockwiseAnimationController
            ..reset()
            ..forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _counterClockwiseAnimationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockwiseAnimationController
      ..reset()
      ..forward.delayed(const Duration(
        seconds: 1,
      ));

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: _changeAnimationNotifier,
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(
                    _counterClockwiseRotationAnimation.value,
                  ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipPath(
                        clipper: const HalfCircleClipper(side: CircleSide.left),
                        child: Container(
                          width: 150,
                          height: 150,
                          color: const Color(0xff0057b7),
                        ),
                      ),
                      ClipPath(
                        clipper:
                            const HalfCircleClipper(side: CircleSide.right),
                        child: Container(
                          width: 150,
                          height: 150,
                          color: const Color(0xffffd700),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }

    path.arcToPoint(
      offset,
      radius: Radius.circular(size.width / 2),
      clockwise: clockwise,
    );
    path.close();

    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const HalfCircleClipper({
    required this.side,
  });

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
