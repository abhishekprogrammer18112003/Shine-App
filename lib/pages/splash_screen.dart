// ignore_for_file: camel_case_types
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shine_app/constants.dart';

import 'package:shine_app/pages/personal_details.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  Future<void> _requestStoragePermission() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 700),
        content: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          // padding: EdgeInsets.all(16),
          height: 40,
          decoration: const BoxDecoration(
              color: Color.fromARGB(192, 252, 48, 48),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Center(
              child: Text(
            "===============processing===================",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        )));
    print("not granted");
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      print("granted");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: const Duration(milliseconds: 700),
          content: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            // padding: EdgeInsets.all(16),
            height: 40,
            decoration: const BoxDecoration(
                color: Color.fromARGB(192, 252, 48, 48),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Center(
                child: Text(
              "=========================Permision Granted===========================",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          )));
      await getAuditedPersonList();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => (PersonalDetails(
                    AuditedPersonList: _AuditedPersonList,
                    selectedAuditedPerson: _selectedAuditedPerson,
                    auditedByIndex: _auditedByIndex,
                  ))));
      // });
      // Permission has been granted, perform your desired action
      // ...
    } else if (status.isDenied) {
      print("granted status denied");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: const Duration(milliseconds: 700),
          content: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            // padding: EdgeInsets.all(16),
            height: 40,
            decoration: const BoxDecoration(
                color: Color.fromARGB(192, 252, 48, 48),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Center(
                child: Text(
              "=====================Permission denied===================",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          )));
      _getpermission();
      // Permission has been denied, handle it accordingly
      // ...
    } else if (status.isPermanentlyDenied) {
      print("granted status permenently denied");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: const Duration(milliseconds: 700),
          content: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            // padding: EdgeInsets.all(16),
            height: 40,
            decoration: const BoxDecoration(
                color: Color.fromARGB(192, 252, 48, 48),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Center(
                child: Text(
              "======================Permanently Denied Permission ==========================",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          )));

      // Permission has been permanently denied, handle it accordingly
      // ...
      bool isOpened = await openAppSettings();

      // Check if the app settings screen was opened
      if (isOpened) {
        // The user opened the app settings screen, handle it accordingly
        // ...
      } else {
        // The user did not open the app settings screen, handle it accordingly
        // ...
      }
      _getpermission();
    }
  }

  _getpermission() async {
    // await _requestStoragePermission();
    await getAuditedPersonList();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => (PersonalDetails(
                  AuditedPersonList: _AuditedPersonList,
                  selectedAuditedPerson: _selectedAuditedPerson,
                  auditedByIndex: _auditedByIndex,
                ))));
  }

  @override
  void initState() {
    super.initState();
    _getpermission();
  }

  //----------------------------------------------------------------------------
  //------Audited Person List---------------------------------------------------
  String? _selectedAuditedPerson;
  String? _auditedByIndex;
  List<dynamic> _AuditedPersonList = [];

  Future<List?> getAuditedPersonList() async {
    print('****************************');
    final response =
        await http.post(Uri.parse(apiurl + "Employee-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching Audited Person List");
      final data = jsonDecode(response.body.toString());
      _AuditedPersonList.addAll(data['employee_list']);
      return _AuditedPersonList;
    } else {
      return null;
    }
  }
  //-----------End Audited Person fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.29,
        ),
        SizedBox(
          height: 80,
          width: 300,
          child: Image.asset(
            appiconimage,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        // Text(
        //   appname,
        //   style: const TextStyle(
        //       color: Colors.deepPurple,
        //       fontWeight: FontWeight.w800,
        //       fontSize: 26,
        //       letterSpacing: 6,
        //       fontStyle: FontStyle.italic),
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        const CircularProgressIndicator(),
      ]),
    ));
  }
}
