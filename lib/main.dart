import 'package:flutter/material.dart';
import 'package:inventra/screen/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: splash_sceen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class splash_sceen extends StatelessWidget {
  const splash_sceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
        splash: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment(1.8, -2.5),
                image: AssetImage('assets/icon/background.png'),
              ),
            ),
            child: Container(
              child: Column(
                children: [head_image(), sub_image(), logo_image()],
              ),
            ),
          ),
        ),
        nextScreen: const Mylogin(),
        splashIconSize: 600,
        duration: 2000,
      ),
    );
  }

  // this is image get from the figma
  Widget head_image() {
    return Container(
      padding: const EdgeInsets.only(top: 200.0, bottom: 15),
      child: Image.asset(
        'assets/icon/head.png',
        width: 150,
      ),
    );
  }

  // this is image get from the figma
  Widget sub_image() {
    return Container(
      padding: const EdgeInsets.only(bottom: 315.0),
      child: Image.asset(
        'assets/icon/sub_head_splash.png',
        width: 250,
      ),
    );
  }

  // this is image get from the figma
  Widget logo_image() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        'assets/icon/logo.png',
        width: 150,
      ),
    );
  }
}
