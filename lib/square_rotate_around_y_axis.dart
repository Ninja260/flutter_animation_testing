import 'dart:math' show pi;

import 'package:flutter/material.dart';

class SquareRotateAroundYAxis extends StatefulWidget {
  const SquareRotateAroundYAxis({
    super.key,
  });

  static const String route = '/square-rotate-around-y-axis';

  @override
  State<SquareRotateAroundYAxis> createState() =>
      _SquareRotateAroundYAxisState();
}

class _SquareRotateAroundYAxisState extends State<SquareRotateAroundYAxis>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(
      _animationController,
    );

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
