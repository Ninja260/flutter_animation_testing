import 'package:animation/animated_container_page.dart';
import 'package:animation/circle_animation_page.dart';
import 'package:animation/color_circle_page.dart';
import 'package:animation/cube_3d_animation_page.dart';
import 'package:animation/custom_painter_polygon_animation_page.dart';
import 'package:animation/hero_animation_page.dart';
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
    List<Page> pageList = const <Page>[
      Page(
        title: 'Circle Animation',
        route: CircleAnimationPage.route,
      ),
      Page(
        title: 'Square Rotate around Y-Axis',
        route: SquareRotateAroundYAxis.route,
      ),
      Page(
        title: 'Cube 3D Animation',
        route: Cube3DAnimationPage.route,
      ),
      Page(
        title: 'Hero animation',
        route: HeroAnimationPage.route,
      ),
      Page(
        title: 'Animated Container',
        subtitle: 'Implicit animation',
        route: AnimatedContainerPage.route,
      ),
      Page(
        title: 'Color Circle Animation',
        route: ColorCirclePage.route,
      ),
      Page(
        title: 'Custom painter polygon animation',
        route: CustomPainterPolygonAnimationPage.route,
      ),
    ];

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
                    for (final page in pageList)
                      ListTile(
                        title: Text(
                          page.title,
                        ),
                        subtitle: page.subtitle != null
                            ? Text(
                                page.subtitle!,
                              )
                            : null,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            page.route,
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

@immutable
class Page {
  const Page({
    required this.title,
    this.subtitle,
    required this.route,
  });

  final String title;
  final String? subtitle;
  final String route;
}
