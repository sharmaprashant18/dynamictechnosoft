import 'dart:async';

import 'package:dynamictechnosoft/view/on_boarding_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 5), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Image(image: AssetImage('assets/loadingpage.png'))),
      ),
    );
  }
}