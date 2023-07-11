import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shine_app/pages/info_page.dart';
import 'package:shine_app/pages/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class SavedPage extends StatefulWidget {
  SavedPage({
    super.key,
  });

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  List<dynamic> _internalPremises = [];
  List<String> _images = [];

  String? selectedAuditedPerson;
  String? auditedByIndex;
  List<dynamic>? AuditedPersonList;
  List<dynamic>? locationList;
  List<dynamic>? cleaningIssueList;
  List<dynamic>? structuralIssueList;
  List<dynamic>? accessIssueList;
  List<dynamic>? infestationList;
  List<dynamic>? observationList;
  List<dynamic>? preventiveList;
  List<dynamic>? curativeList;
  String? auditedOn;
  String? clientName;
  String? clientPhoneNumber;
  String? facilityName;
  String? facilityLocation;
  String? noteText;
  String? facilitySurrounding;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic encodedListPremises = await prefs.getString('premisesList');
    _internalPremises = jsonDecode(encodedListPremises!);
    dynamic encodedListImages = await prefs.getString('imagesList');
    _images = jsonDecode(encodedListImages!);
    auditedOn = await prefs.getString('auditedOn')!;
    clientName = await prefs.getString('clientName')!;
    clientPhoneNumber = await prefs.getString('clientPhoneNumber')!;
    facilityName = await prefs.getString('facilityname')!;
    selectedAuditedPerson = await prefs.getString('facilityLocation');
    facilitySurrounding = await prefs.getString('facilitySurrounding')!;
    noteText = await prefs.getString('note')!;
    auditedByIndex = await prefs.getString('auditedIndex')!;

    print(_internalPremises);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Confirmation'),
              content: Text('Do you want to exit?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          );

          return shouldExit ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [],
            title: Text(
              'Get All Saved Premises',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
              itemCount: _internalPremises.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(199, 158, 158, 158)
                              .withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Premises " + (index + 1).toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),

                        //=============EDIT=========

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoPremisesPage(
                                          premises: _internalPremises,
                                          imagePath: _images[index],
                                        )));
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Icon(
                                Icons.info_outline_rounded,
                                color: Colors.white,
                              )),
                        ),

                        //=============DELETE========

                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _internalPremises.removeAt(index);
                            });
                            print(_internalPremises);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  bool _isloading = false;

  Future<void> _submitForm() async {
    print("**********************");
    setState(() {
      _isloading = true;
    });
    print(facilitySurrounding);
    print(noteText);
    print(auditedOn);
    print(clientName);
    print(clientPhoneNumber);
    print(facilityName);
    print(facilityLocation);
    print('=======internal premises');
    print(_internalPremises);

    print('===========images');
    print(_images);

    FormData formData = FormData.fromMap({
      'enc_string': 'ShinePeSTReporT',
      'audit_on': auditedOn.toString(),
      'expert_id': auditedByIndex.toString(),
      'client_name': clientName.toString(),
      'client_no': clientPhoneNumber.toString(),
      'audit_by': selectedAuditedPerson.toString(),
      'facility_name': facilityName.toString(),
      'facility_loc': facilityLocation.toString(),
      for (var i = 0; i < _images.length; i++)
        'internal_capture_img_${i + 1}':
            await MultipartFile.fromFile(_images[i]),
      'premises': json.encode(_internalPremises),
      'auth_person_id': auditedByIndex.toString(),
      'note': noteText.toString(),
      'facility_surroundings': facilitySurrounding.toString(),
    });
    try {
      String url = apiurl + "Report-Generation";
      var response = await Dio().post(url, data: formData);
      print(response);
      var data = response.data;

      print("*************************************");

      setState(() {
        _isloading = false;
      });

      if (response.statusCode == 200) {
        print("*****************");
        print(data);

        if (data['status'] == 'Success') {
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleDownloadScreen(
                        url: data['file_path'],
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                padding: const EdgeInsets.all(16),
                height: 50,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Center(child: Text("Something Went Wrong")),
              )));
          setState(() {
            _isloading = false;
          });
        }
      } else {
        setState(() {
          _isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              padding: const EdgeInsets.all(16),
              height: 50,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Center(child: Text("Please Try again")),
            )));

        // Login failed.
        // You can display an error message here.
      }
    } catch (e) {
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
            child: Center(
                child: Text(
              e.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          )));
      print(e);
      setState(() {
        _isloading = false;
      });
    }
  }
}
