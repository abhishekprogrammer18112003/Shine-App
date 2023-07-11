import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shine_app/pages/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../widgets/myappbarwidget.dart';
import 'add_premises_page.dart';
import 'edit_premises_page.dart';

class PremisesPage extends StatefulWidget {
  String? selectedAuditedPerson;
  String? auditedByIndex;
  List<dynamic> AuditedPersonList;
  List<dynamic> locationList;
  List<dynamic> cleaningIssueList;
  List<dynamic> structuralIssueList;
  List<dynamic> accessIssueList;
  List<dynamic> infestationList;
  List<dynamic> observationList;
  List<dynamic> preventiveList;
  List<dynamic> curativeList;
  String auditedOn;
  String clientName;
  String clientPhoneNumber;
  String facilityName;
  String facilityLocation;
  String noteText;
  String facilitySurrounding;
  PremisesPage(
      {super.key,
      required this.AuditedPersonList,
      required this.accessIssueList,
      required this.auditedByIndex,
      required this.cleaningIssueList,
      required this.curativeList,
      required this.infestationList,
      required this.locationList,
      required this.observationList,
      required this.preventiveList,
      required this.selectedAuditedPerson,
      required this.structuralIssueList,
      required this.auditedOn,
      required this.clientName,
      required this.clientPhoneNumber,
      required this.facilityLocation,
      required this.facilityName,
      required this.facilitySurrounding,
      required this.noteText});

  @override
  State<PremisesPage> createState() => _PremisesPageState();
}

class _PremisesPageState extends State<PremisesPage> {
  List<dynamic> _internalPremises = [];
  List<String> _images = [];
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
              actions: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 15.0),
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Icon(
                //       Icons.save,
                //       size: 28,
                //     ),
                //   ),
                // )
              ],
              title: Text(
                'Get All Premises',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            // appBar: PreferredSize(
            //     preferredSize: Size.fromHeight(51), child: MyAppBarWidget()),
            floatingActionButton: FloatingActionButton(
                // shape: CircleBorder(),
                backgroundColor: Colors.deepPurple,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPremisesPage(
                                AuditedPersonList: widget.AuditedPersonList,
                                selectedAuditedPerson:
                                    widget.selectedAuditedPerson,
                                auditedByIndex: widget.auditedByIndex,
                                accessIssueList: widget.accessIssueList,
                                cleaningIssueList: widget.cleaningIssueList,
                                curativeList: widget.curativeList,
                                infestationList: widget.infestationList,
                                locationList: widget.locationList,
                                observationList: widget.observationList,
                                preventiveList: widget.preventiveList,
                                structuralIssueList: widget.structuralIssueList,
                              ))).then((value) {
                    print(value);
                    setState(() {
                      _internalPremises.add(value['store']);
                      _images.add(value['image']);
                    });

                    print(_internalPremises);
                    print(_images);
                  });
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            body: _internalPremises.isEmpty
                ? Center(
                    child: Text("No Premises Added"),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
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
                                        color:
                                            Color.fromARGB(199, 158, 158, 158)
                                                .withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Premises " + (index + 1).toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.deepPurple),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                      ),

                                      //=============EDIT=========
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPremisesPage(
                                                        premises:
                                                            _internalPremises[
                                                                index],
                                                        AuditedPersonList: widget
                                                            .AuditedPersonList,
                                                        selectedAuditedPerson:
                                                            widget
                                                                .selectedAuditedPerson,
                                                        auditedByIndex: widget
                                                            .auditedByIndex,
                                                        accessIssueList: widget
                                                            .accessIssueList,
                                                        cleaningIssueList: widget
                                                            .cleaningIssueList,
                                                        curativeList:
                                                            widget.curativeList,
                                                        infestationList: widget
                                                            .infestationList,
                                                        locationList:
                                                            widget.locationList,
                                                        observationList: widget
                                                            .observationList,
                                                        preventiveList: widget
                                                            .preventiveList,
                                                        structuralIssueList: widget
                                                            .structuralIssueList,
                                                        image: _images[index],
                                                      ))).then((value) {
                                            setState(() {
                                              _internalPremises[index] =
                                                  value['store'];
                                              _images[index] = value['image'];
                                            });

                                            print(_internalPremises);
                                          });
                                        },
                                        child: CircleAvatar(
                                            backgroundColor: Colors.deepPurple,
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            )),
                                      ),

                                      //=============DELETE========

                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            _internalPremises.removeAt(index);
                                            _images.removeAt(index);
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        // _saved
                        //     ? Container()
                        //     : GestureDetector(
                        //         onTap: () {
                        //           _save();
                        //         },
                        //         child: Container(
                        //             height: 46,
                        //             width: 100,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(6),
                        //               color: Colors.deepPurple,
                        //             ),
                        //             child: !_isloading
                        //                 ? Center(
                        //                     child: Text("Save",
                        //                         style: TextStyle(
                        //                             color: Colors.white,
                        //                             fontSize: 17)),
                        //                   )
                        //                 : Center(
                        //                     child: CircularProgressIndicator(),
                        //                   )),
                        //       ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.02,
                        // ),
                        GestureDetector(
                          onTap: () {
                            _submitForm();
                          },
                          child: Container(
                              height: 46,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.green,
                              ),
                              child: !_isloading
                                  ? Center(
                                      child: Text("Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17)),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    )),
                        ),
                      ]),
                    ),
                  )));
  }

  bool _isloading = false;

  Future<void> _submitForm() async {
    print("**********************");
    setState(() {
      _isloading = true;
    });
    print(widget.facilitySurrounding);
    print(widget.noteText);
    print(widget.auditedOn);
    print(widget.clientName);
    print(widget.clientPhoneNumber);
    print(widget.facilityName);
    print(widget.facilityLocation);
    print('=======internal premises');
    print(_internalPremises);

    print('===========images');
    print(_images);

    FormData formData = FormData.fromMap({
      'enc_string': 'ShinePeSTReporT',
      'audit_on': widget.auditedOn.toString(),
      'expert_id': widget.auditedByIndex.toString(),
      'client_name': widget.clientName.toString(),
      'client_no': widget.clientPhoneNumber.toString(),
      'audit_by': widget.selectedAuditedPerson.toString(),
      'facility_name': widget.facilityName.toString(),
      'facility_loc': widget.facilityLocation.toString(),
      for (var i = 0; i < _images.length; i++)
        'internal_capture_img_${i + 1}':
            await MultipartFile.fromFile(_images[i]),
      'premises': json.encode(_internalPremises),
      'auth_person_id': widget.auditedByIndex.toString(),
      'note': widget.noteText.toString(),
      'facility_surroundings': widget.facilitySurrounding.toString(),
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

  bool _saved = false;

  _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('premisesList', jsonEncode(_internalPremises));
    await prefs.setString('imagesList', jsonEncode(_images));
    await prefs.setString('auditedOn', widget.auditedOn);
    await prefs.setString('clientName', widget.clientName);
    await prefs.setString('clientPhoneNumber', widget.clientPhoneNumber);
    await prefs.setString('auditedBy', widget.selectedAuditedPerson!);
    await prefs.setString('facilityname', widget.facilityName);
    await prefs.setString('facilityLocation', widget.facilityLocation);
    await prefs.setString('facilitySurrounding', widget.facilitySurrounding);
    await prefs.setString('note', widget.noteText);
    await prefs.setString('auditedIndex', widget.auditedByIndex!);

    setState(() {
      _saved = true;
    });
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
            'Successfully Saved',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        )));
  }
}
