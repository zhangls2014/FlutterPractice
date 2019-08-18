import 'package:flutter/material.dart';

import 'page_unknown_route.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: Routes.PAGE_SPLASH,
      onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(builder: (context) => PageUnknownRoute()),
      routes: Routes.getRoutes(context),
    );
  }
}

class SplashAnimationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashAnimationState();
  }
}

class SplashAnimationState extends State<SplashAnimationWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 120.0).animate(curve)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 将旧的页面全部弹出后进入新的页面
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.PAGE_HOME, (Route<dynamic> route) => false,
              arguments: 'Flutter Practice Home Page');
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: animation.value,
          height: animation.value,
          child: FlutterLogo(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
