import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Log%20In/log_in_screen.dart';
import 'package:pet_life_gh/screens/wrapper.dart';

class NextSplashScreen extends StatelessWidget {
  const NextSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: 300,
        backgroundColor: blue,
        splash: Image.asset("asset/images/logo.png"),
        nextScreen: Wrapper(),
        duration: 3000,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        splashTransition: SplashTransition.rotationTransition,
      ),
    );
  }
}
