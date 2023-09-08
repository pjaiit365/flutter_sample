import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pet_life_gh/constants.dart';

import 'next_splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: 300,
        splash: Image.asset("asset/images/logo.png",color: blue,),
        nextScreen: NextSplashScreen(),
        animationDuration: Duration(seconds: 2),
        pageTransitionType: PageTransitionType.fade,
        splashTransition: SplashTransition.scaleTransition,
      ),
    );
    
  }
}
