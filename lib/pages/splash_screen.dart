import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shine_app/constants.dart';
import 'package:shine_app/pages/homepage.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home_Page()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: Get.height * 0.29,
        ),
        SizedBox(
          height: Get.height * 0.15,
          width: Get.width * 0.3,
          child: Image.asset(
            appiconimage,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Text(
          appname,
          style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w800,
              fontSize: 26,
              letterSpacing: 6,
              fontStyle: FontStyle.italic),
        ),
        SizedBox(
          height: Get.height * 0.15,
        ),
        const CircularProgressIndicator(),
      ]),
    ));
  }
}
