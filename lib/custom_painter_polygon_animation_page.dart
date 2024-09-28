import 'package:flutter/material.dart';
import 'dart:math' show cos, sin, pi;

class Polygon extends CustomPainter {
  final int sides;

  const Polygon({
    required this.sides,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();

    final center = Offset(size.width / 2, size.height / 2);
    final angle = (2 * pi) / sides;

    final angles = List.generate(
      sides,
      (i) => angle * i,
      growable: false,
    );

    final radius = size.width / 2;

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}

class CustomPainterPolygonAnimationPage extends StatefulWidget {
  const CustomPainterPolygonAnimationPage({super.key});

  static const String route = '/custom-painter-ploygon-animation-page';

  @override
  State<CustomPainterPolygonAnimationPage> createState() =>
      _CustomPainterPolygonAnimationPageState();
}

class _CustomPainterPolygonAnimationPageState
    extends State<CustomPainterPolygonAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _sideController;
  late Animation<int> _sideAnimation;

  late AnimationController _radiusController;
  late Animation<double> _radiusAnimation;

  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  late Listenable _changeAnimationListener;

  @override
  void initState() {
    super.initState();
    _sideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _sideAnimation = IntTween(
      begin: 3,
      end: 10,
    ).animate(_sideController);

    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _radiusAnimation = Tween<double>(
      begin: 20.0,
      end: 400.0,
    )
        .chain(
          CurveTween(
            curve: Curves.bounceInOut,
          ),
        )
        .animate(
          _radiusController,
        );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    _rotationAnimation = Tween(
      begin: 0.0,
      end: 2 * pi,
    )
        .chain(
          CurveTween(
            curve: Curves.easeInOut,
          ),
        )
        .animate(_rotationController);

    _changeAnimationListener = Listenable.merge([
      _sideController,
      _radiusController,
      _rotationController,
    ]);
  }

  @override
  void dispose() {
    _sideController.dispose();
    _radiusController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sideController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedBuilder(
            animation: _changeAnimationListener,
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_rotationAnimation.value)
                  ..rotateY(_rotationAnimation.value)
                  ..rotateZ(_rotationAnimation.value),
                child: CustomPaint(
                  painter: Polygon(
                    sides: _sideAnimation.value,
                  ),
                  child: SizedBox(
                    width: _radiusAnimation.value,
                    height: _radiusAnimation.value,
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
