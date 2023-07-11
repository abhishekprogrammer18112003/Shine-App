// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../constants.dart';

class MyAppBarWidget extends StatefulWidget {
  const MyAppBarWidget({super.key});

  @override
  State<MyAppBarWidget> createState() => _MyAppBarWidgetState();
}

class _MyAppBarWidgetState extends State<MyAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        // Text("pdf", style: TextStyle(color: Colors.white60)),
        // GestureDetector(
        //   onTap: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: ((context) => SavedPremises())));
        //   },
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Icon(
            Icons.save,
            color: Colors.white70,
            size: 27,
          ),
        ),
      ],
      backgroundColor: Colors.deepPurple,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          "$appname App",
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 3,
              fontSize: 19),
        ),
      ),
    );
  }
}
