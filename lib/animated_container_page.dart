import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  const AnimatedContainerPage({super.key});

  static const String route = '/animated-container';

  @override
  State<AnimatedContainerPage> createState() => _AnimatedContainerPageState();
}

const double _defaultWidth = 200.0;

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  bool _isZoomedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Center(
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 370,
                  ),
                  width: _isZoomedIn
                      ? MediaQuery.of(context).size.width
                      : _defaultWidth,
                  curve: _isZoomedIn ? Curves.bounceOut : Curves.bounceIn,
                  child: Image.asset(
                    'images/assasin-creed.jpg',
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: Text(
                    _isZoomedIn ? 'Zoom Out' : 'Zoom In',
                  ),
                  onPressed: () {
                    setState(() {
                      _isZoomedIn = !_isZoomedIn;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
