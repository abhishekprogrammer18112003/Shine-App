import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shine_app/pages/premises_page.dart';
import 'package:http/http.dart' as http;
import 'package:shine_app/pages/saved_premises.dart';
import '../constants.dart';
import '../widgets/myappbarwidget.dart';

class PersonalDetails extends StatefulWidget {
  String? selectedAuditedPerson;
  String? auditedByIndex;
  List<dynamic> AuditedPersonList;
  PersonalDetails(
      {super.key,
      required this.selectedAuditedPerson,
      required this.AuditedPersonList,
      required this.auditedByIndex});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _clientName = TextEditingController();
  TextEditingController _clientPhoneNumber = TextEditingController();
  TextEditingController _facilityName = TextEditingController();
  TextEditingController _facilityLocation = TextEditingController();
  TextEditingController reviewdateinput = TextEditingController();
  TextEditingController completiondateinput = TextEditingController();
  TextEditingController auditedondateinput = TextEditingController();
  TextEditingController _facilitySurroundingController =
      TextEditingController();
  TextEditingController _noteController = TextEditingController();
  String? facilitytext =
      "In Our Audit your facility surrounded Thick Vegetation. Major thread for the surrounding is Flying insects, Rodents, Spiders, Snakes & Other Crawling insects.";
  String? notetext =
      "Note: In General your all window mesh will be replaced all windows. Also in Processing area. Fly Killer Machine will be placed to Fly Catcher Machines";

  _getAllData() async {
    await getLocationList();
    await getCleaningIssueList();
    await getStructuralIssueList();
    await getAccessIssueList();
    await getInfestationList();
    await getObservationList();
    await getPreventiveList();
    await getCurativeList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationList();
    getCleaningIssueList();
    getStructuralIssueList();
    getAccessIssueList();
    getInfestationList();
    getObservationList();
    getPreventiveList();
    getCurativeList();
  }

  void show() {
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
            "Please enter the required fields.",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        )));
  }

  void next() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PremisesPage(
                  AuditedPersonList: widget.AuditedPersonList,
                  selectedAuditedPerson: widget.selectedAuditedPerson,
                  auditedByIndex: widget.auditedByIndex,
                  accessIssueList: _accessIssueList,
                  cleaningIssueList: _cleaningIssueList,
                  curativeList: _curativeList,
                  infestationList: _infestationList,
                  locationList: _locationList,
                  observationList: _observationList,
                  preventiveList: _preventiveList,
                  structuralIssueList: _structuralIssueList,
                  auditedOn: auditedondateinput.text,
                  clientName: _clientName.text,
                  clientPhoneNumber: _clientPhoneNumber.text,
                  facilityName: _facilityName.text,
                  facilityLocation: _facilityLocation.text,
                  noteText: _noteController.text.isEmpty
                      ? notetext!
                      : _noteController.text,
                  facilitySurrounding:
                      _facilitySurroundingController.text.isEmpty
                          ? facilitytext!
                          : _facilitySurroundingController.text,
                )));
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
            automaticallyImplyLeading: false,
            actions: [
              // Text("pdf", style: TextStyle(color: Colors.white60)),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: ((context) => SavedPage())));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Icon(
                    Icons.save,
                    color: Colors.white70,
                    size: 27,
                  ),
                ),
              )
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
          ),
          // body: PageView(
          //   physics: const NeverScrollableScrollPhysics(),
          //   controller: _pageController,
          //   children: [_form1(), _form2()],
          // ),
          body: _buildPersonalDetails(),
        ));
  }

  Widget _buildPersonalDetails() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("Person Details",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 30,
                ),

                TextFormField(
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: 'Audited By',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                        text: widget.selectedAuditedPerson),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Select the Audited Person',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              content: Container(
                                width: double.maxFinite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.AuditedPersonList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.selectedAuditedPerson = widget
                                              .AuditedPersonList[index]['name'];
                                          widget.auditedByIndex = widget
                                              .AuditedPersonList[index]['id'];
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                              widget.AuditedPersonList[index]
                                                  ['name']),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          });
                    }),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller:
                      auditedondateinput, //editing controller of this TextField
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Audited on", //label text of field
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  validator: (value) {
                    //
                    if (value == null || value.isEmpty) {
                      return "Required field";
                    }
                    return null;
                  }, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          intl.DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        auditedondateinput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Completion Date is not selected");
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                //Client Name
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _clientName,
                  decoration: const InputDecoration(
                    labelText: 'Client Name',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Client name';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 10,
                ),

                //building sqft
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _clientPhoneNumber,
                  // obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Client Contact Nunber',
                    border: OutlineInputBorder(),
                  ),

                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Client Contact Number';
                    }
                    if (value.length != 10) {
                      return 'Please Enter the correct Contact Number';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                //Facility name
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _facilityName,
                  decoration: const InputDecoration(
                    labelText: 'Facilty Name',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Facility name';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                //Facility location
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _facilityLocation,
                  decoration: const InputDecoration(
                    labelText: 'Facility Location',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Facility Location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // const Text("Facility Surrounding",
                //     style:
                //         TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                // const SizedBox(height: 30),

                TextFormField(
                  controller: _facilitySurroundingController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "facility Surrounding.....",
                    // 'In Our Audit your facility surrounded Thick Vegetation. \nMajor thread for the surrounding is Flying insects, Rodents, Spiders, Snakes & Other Crawling insects.',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Any Note....",
                    // 'Note: In General your all window mesh will be replaced all windows. Also in Processing area. Fly Killer Machine will be placed to Fly Catcher Machines',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Container(
                          height: 46,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.deepPurple,
                          ),
                          child: const Center(
                            child: Text("Next",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          )),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // _currentPageIndex++;
                          // _pageController.nextPage(
                          //   duration: const Duration(milliseconds: 300),
                          //   curve: Curves.easeInOut,
                          // );
                          widget.selectedAuditedPerson == null
                              ? show()
                              : next();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //==========================API INTEGRATION ==========================================

  //----------------------------------------------------------------------------
  //------Location List---------------------------------------------------

  List<dynamic> _locationList = [];

  Future<List?> getLocationList() async {
    print('****************************');
    final response =
        await http.post(Uri.parse(apiurl + "Location-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching location List");
      final data = jsonDecode(response.body.toString());
      _locationList.addAll(data['location_name']);
      return _locationList;
    } else {
      return null;
    }
  }
  //-----------End location fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //------Cleaning issue List---------------------------------------------------

  List<dynamic> _cleaningIssueList = [];

  Future<List?> getCleaningIssueList() async {
    print('****************************');
    final response =
        await http.post(Uri.parse(apiurl + "Cleaning-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching cleaning List");
      final data = jsonDecode(response.body.toString());
      _cleaningIssueList.addAll(data['cleaning_issues']);
      return _cleaningIssueList;
    } else {
      return null;
    }
  }
  //-----------End Cleaning issue fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //------Structural issue List---------------------------------------------------

  List<dynamic> _structuralIssueList = [];

  Future<List?> getStructuralIssueList() async {
    print('****************************');
    final response =
        await http.post(Uri.parse(apiurl + "Structural-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching structural issues List");
      final data = jsonDecode(response.body.toString());
      _structuralIssueList.addAll(data['structural_issues']);
      return _structuralIssueList;
    } else {
      return null;
    }
  }
  //-----------End structural issue fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //------Access issue List---------------------------------------------------

  List<dynamic> _accessIssueList = [];

  Future<List?> getAccessIssueList() async {
    print('****************************');
    final response = await http.post(Uri.parse(apiurl + "Access-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching access issues List");
      final data = jsonDecode(response.body.toString());
      _accessIssueList.addAll(data['access_data']);
      return _accessIssueList;
    } else {
      return null;
    }
  }
  //-----------End structural issue fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //------Infestation List---------------------------------------------------

  List<dynamic> _infestationList = [];

  Future<List?> getInfestationList() async {
    print('****************************');
    final response =
        await http.post(Uri.parse(apiurl + "Infestation-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching infestation List");
      final data = jsonDecode(response.body.toString());
      _infestationList.addAll(data['infestation_name']);
      return _infestationList;
    } else {
      return null;
    }
  }
  //-----------End Infestation fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //-----Observations List---------------------------------------------------

  List<dynamic> _observationList = [];

  Future<List?> getObservationList() async {
    print('****************************');
    final response =
        await http.post(Uri.parse(apiurl + "Observations-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching observation List");
      final data = jsonDecode(response.body.toString());
      _observationList.addAll(data['observations_name']);
      return _observationList;
    } else {
      return null;
    }
  }
  //-----------End Observations fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //------Preventions List---------------------------------------------------

  List<dynamic> _preventiveList = [];

  Future<List?> getPreventiveList() async {
    print('****************************');
    final response =
        await http.post(Uri.parse(apiurl + "Preventive-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching preventive List");
      final data = jsonDecode(response.body.toString());
      _preventiveList.addAll(data['preventive_name']);
      return _preventiveList;
    } else {
      return null;
    }
  }
  //-----------End Preventions fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //------Preventions List---------------------------------------------------

  List<dynamic> _curativeList = [];

  Future<List?> getCurativeList() async {
    print('****************************');
    final response =
        await http.post(Uri.parse(apiurl + "Curative-List"), body: {
      'enc_string': 'ShinePeSTReporT',
    });

    if (response.statusCode == 200) {
      print("done Fetching curative List");
      final data = jsonDecode(response.body.toString());
      _curativeList.addAll(data['curative_name']);
      return _curativeList;
    } else {
      return null;
    }
  }
  //-----------End curative fetch----------------------------------------------------
  //----------------------------------------------------------------------------------------
}
