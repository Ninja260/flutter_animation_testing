import 'package:animation/circle_animation_page.dart';
import 'package:animation/cube_3d_animation_page.dart';
import 'package:animation/square_rotate_around_y_axis.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text(
                        'Circle Animation',
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          CircleAnimationPage.route,
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Square Rotate around Y-Axis'),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          SquareRotateAroundYAxis.route,
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Cube 3D Animation'),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Cube3DAnimationPage.route,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
