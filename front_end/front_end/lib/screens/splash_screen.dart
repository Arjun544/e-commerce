import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import 'dart:math' as math; 

import 'register_screen/register_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacement(
              ThisIsFadeRoute(route: RegisterScreen(), page: RegisterScreen()),
            );
            Timer(
              const Duration(milliseconds: 300),
              () {
                scaleController.reset();
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  // @override
  // void dispose() {
  //   scaleController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(seconds: 6),
          opacity: _opacity,
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(seconds: 7),
            height: _value ? 50 : 100,
            width: _value ? 50 : 100,
            child: Center(
              child: AnimatedBuilder(
                animation: scaleAnimation,
                builder: (c, child) => Transform.scale(
                  scale: scaleAnimation.value,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: RotatedBox(
                      quarterTurns: 5,
                      child: SvgPicture.asset(
                        'assets/images/Activity.svg',
                        color: customYellow,
                        height: 7,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({required this.page, required this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}