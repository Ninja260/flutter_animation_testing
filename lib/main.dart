import 'package:animation/animated_container_page.dart';
import 'package:animation/circle_animation_page.dart';
import 'package:animation/cube_3d_animation_page.dart';
import 'package:animation/hero_animation_page.dart';
import 'package:animation/my_home_page.dart';
import 'package:animation/square_rotate_around_y_axis.dart';
import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: MyHomePage.route,
      routes: {
        MyHomePage.route: (context) => const MyHomePage(
              title: 'Flutter Animation Example',
            ),
        CircleAnimationPage.route: (context) => const BackableWidget(
              child: CircleAnimationPage(),
            ),
        SquareRotateAroundYAxis.route: (context) => const BackableWidget(
              child: SquareRotateAroundYAxis(),
            ),
        Cube3DAnimationPage.route: (context) => const BackableWidget(
              child: Cube3DAnimationPage(),
            ),
        HeroAnimationPage.route: (context) => const BackableWidget(
              child: HeroAnimationPage(),
            ),
        AnimatedContainerPage.route: (context) => const BackableWidget(
              child: AnimatedContainerPage(),
            ),
      },
    );
  }
}

class BackableWidget extends StatelessWidget {
  const BackableWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).popUntil(
            ModalRoute.withName(
              MyHomePage.route,
            ),
          );
        },
        child: const BackButton(),
      ),
      body: child,
    );
  }
}
