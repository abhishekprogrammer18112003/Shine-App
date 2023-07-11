// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unused_field, depend_on_referenced_packages

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';

class AddPremisesPage extends StatefulWidget {
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
  AddPremisesPage(
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
      required this.structuralIssueList});

  @override
  State<AddPremisesPage> createState() => _AddPremisesPageState();
}

class _AddPremisesPageState extends State<AddPremisesPage> {
  final _formKey = GlobalKey<FormState>();
  int _countIndex = 0;
  bool _isloading = false;

  //====================CONTROLER'S==================================
  TextEditingController _locationController = TextEditingController();
  TextEditingController _CleaningIssueController = TextEditingController();
  TextEditingController _structuralIssueController = TextEditingController();
  TextEditingController _accessIssueController = TextEditingController();
  TextEditingController _infestationController = TextEditingController();
  TextEditingController _observationController = TextEditingController();
  TextEditingController _preventiveController = TextEditingController();
  TextEditingController _curativeController = TextEditingController();
  TextEditingController reviewdateinput = TextEditingController();
  TextEditingController completiondateinput = TextEditingController();

  ///=============================GLOBAL KEY=============================
  late AutoCompleteTextField textField;
  GlobalKey<AutoCompleteTextFieldState<String>> locationkey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> cleaningkey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> accesskey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> structuralkey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> infestationkey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> observationkey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> preventivekey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> curativekey = GlobalKey();

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
            title: Text("Add Premises",
                style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
          ),
          body: _buildPremisesForm(),
        ));
  }

  Widget _buildPremisesForm() {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  if (_image != null)
                    RepaintBoundary(
                      key: _arrowKey,
                      child: Stack(
                        children: [
                          Image.file(_image!),
                          Positioned(
                            left: _arrowPosition.dx,
                            top: _arrowPosition.dy,
                            child: Draggable(
                                feedback: Icon(
                                  Icons.arrow_forward,
                                  color: _arrowColor.withOpacity(0.7),
                                  size: 40,
                                ),
                                onDraggableCanceled: (velocity, offset) {
                                  setState(() {
                                    _arrowPosition = offset - Offset(20, 120);
                                  });
                                },
                                onDragStarted: () => _startDragging(context),
                                onDragEnd: (details) => _stopDragging(context),
                                onDragUpdate: (details) =>
                                    _dragging(context, details),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: _arrowColor,
                                  size: 60,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () => getImageFromCamera(),
                    child: Text('Select From Camera'),
                  ),
                  ElevatedButton(
                    onPressed: () => getImageFromgallery(),
                    child: Text('Select From Gallery'),
                  ),
                  // !imageSaved
                  //     ? ElevatedButton(
                  //         onPressed: _saveEditedImage,
                  //         child: Text('Save'),
                  //       )
                  //     : Container(),

                  SizedBox(height: 10),
                  CheckboxListTile(
                    title: Text('Internal Premises'),
                    value: _checkbox1,
                    onChanged: (value) {
                      _onCheckboxChanged(value!, 1);
                    },
                  ),

                  CheckboxListTile(
                    title: Text('External Premises'),
                    value: _checkbox2,
                    onChanged: (value) {
                      _onCheckboxChanged(value!, 2);
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  textField = AutoCompleteTextField<dynamic>(
                    controller: _locationController,
                    key: locationkey,
                    clearOnSubmit: false,
                    suggestions: widget.locationList,
                    decoration: InputDecoration(
                      hintText: 'Location',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    itemFilter: (item, query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        _locationController.text = item;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  textField = AutoCompleteTextField<dynamic>(
                    controller: _CleaningIssueController,
                    key: cleaningkey,
                    clearOnSubmit: false,
                    suggestions: widget.cleaningIssueList,
                    decoration: InputDecoration(
                      hintText: 'Cleaning Issue',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    itemFilter: (item, query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        _CleaningIssueController.text = item;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  textField = AutoCompleteTextField<dynamic>(
                    controller: _structuralIssueController,
                    key: structuralkey,
                    clearOnSubmit: false,
                    suggestions: widget.structuralIssueList,
                    decoration: InputDecoration(
                      hintText: 'Structural Issue',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    itemFilter: (item, query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        _structuralIssueController.text = item;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  textField = AutoCompleteTextField<dynamic>(
                    controller: _accessIssueController,
                    key: accesskey,
                    clearOnSubmit: false,
                    suggestions: widget.accessIssueList,
                    decoration: InputDecoration(
                      hintText: 'Access Issue',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    itemFilter: (item, query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        _accessIssueController.text = item;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  textField = AutoCompleteTextField<dynamic>(
                    controller: _infestationController,
                    key: infestationkey,
                    clearOnSubmit: false,
                    suggestions: widget.infestationList,
                    decoration: InputDecoration(
                      hintText: 'Description of Pest Infestation',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    itemFilter: (item, query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        _infestationController.text = item;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  textField = AutoCompleteTextField<dynamic>(
                    controller: _observationController,
                    key: observationkey,
                    clearOnSubmit: false,
                    suggestions: widget.observationList,
                    decoration: InputDecoration(
                      hintText: 'Any other Observations',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    itemFilter: (item, query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        _observationController.text = item;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  textField = AutoCompleteTextField<dynamic>(
                    controller: _preventiveController,
                    key: preventivekey,
                    clearOnSubmit: false,
                    suggestions: widget.preventiveList,
                    decoration: InputDecoration(
                      hintText: 'Preventive Action Suggested to Customer',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    itemFilter: (item, query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        _preventiveController.text = item;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  textField = AutoCompleteTextField<dynamic>(
                    controller: _curativeController,
                    key: curativekey,
                    clearOnSubmit: false,
                    suggestions: widget.curativeList,
                    decoration: InputDecoration(
                      hintText: 'Curative Actions from',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    itemFilter: (item, query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        _curativeController.text = item;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //REVIEW DATE
                  TextFormField(
                    controller:
                        reviewdateinput, //editing controller of this TextField
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      suffixIcon:
                          Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Review Date", //label text of field
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
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
                          reviewdateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Review Date is not selected");
                      }
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //COMPLETION DATE

                  TextFormField(
                    controller:
                        completiondateinput, //editing controller of this TextField
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      suffixIcon:
                          Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Completion Date", //label text of field
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    // validator: (value) {
                    //   //
                    //   if (value == null || value.isEmpty) {
                    //     return "Please select Completion Date";
                    //   }
                    //   return null;
                    // }, //set it true, so that user will not able to edit text
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
                          completiondateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Completion Date is not selected");
                      }
                    },
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  //ADD MORE PREMISES
                  // GestureDetector(
                  //   onTap: () {
                  //     FocusScope.of(context).unfocus();
                  //     !imageselected ||
                  //             (_checkbox1 && _checkbox2) ||
                  //             reviewdateinput.text == "" ||
                  //             completiondateinput.text == "" ||
                  //             _locationController.text == "" ||
                  //             _CleaningIssueController.text == "" ||
                  //             _structuralIssueController.text == "" ||
                  //             _accessIssueController.text == "" ||
                  //             _infestationController.text == "" ||
                  //             _observationController.text == "" ||
                  //             _preventiveController.text == "" ||
                  //             _curativeController.text == ""
                  //         ? show()
                  //         : addMorePremises();
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.green,
                  //     ),
                  //     height: 40,
                  //     width: 160,
                  //     child: const Center(
                  //         child: Text(
                  //       'Add More Premisis',
                  //       style: TextStyle(color: Colors.white),
                  //     )),
                  //   ),
                  // ),

                  const SizedBox(height: 40.0),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     GestureDetector(
                  //       child: Container(
                  //           height: 46,
                  //           width: 95,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(6),
                  //             border: Border.all(
                  //                 color: Colors.deepPurple, width: 1.5),
                  //             // color: Colors.blue,
                  //           ),
                  //           child: const Center(
                  //             child: Text("Previous",
                  //                 style: TextStyle(
                  //                     color: Colors.deepPurple,
                  //                     fontSize: 17)),
                  //           )),
                  //       onTap: () {
                  //         _pageController.previousPage(
                  //           duration: const Duration(milliseconds: 300),
                  //           curve: Curves.easeInOut,
                  //         );
                  //       },
                  //     ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        !imageselected ||
                                (_checkbox1 && _checkbox2) ||
                                _locationController.text == "" ||
                                _CleaningIssueController.text == "" ||
                                _structuralIssueController.text == "" ||
                                _accessIssueController.text == "" ||
                                _infestationController.text == "" ||
                                _observationController.text == "" ||
                                _preventiveController.text == "" ||
                                _curativeController.text == ""
                            ? show()
                            : save();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.deepPurple,
                      ),
                      height: 46,
                      width: 80,
                      child: _isloading
                          ? const Center(
                              child: SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }

  File? _image;
  final picker = ImagePicker();
  bool imageselected = false;

  Future getImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          imageselected = true;
          // imageflag = '1';
        });
        // print(_image.path);
      }
    } on Exception catch (e) {
      print("failed to pick image : $e");
    }
  }

  Future getImageFromgallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          imageselected = true;
          // imageflag = '1';
        });
        // print(_image.path);
      }
    } on Exception catch (e) {
      print("failed to pick image : $e");
    }
  }

  final GlobalKey<SignatureState> _signatureKey = GlobalKey<SignatureState>();
  String? editedImagePath;

  bool _checkbox1 = false;
  bool _checkbox2 = false;

  void _onCheckboxChanged(bool value, int checkboxNumber) {
    setState(() {
      if (checkboxNumber == 1) {
        _checkbox1 = value;
        _checkbox2 = !value;
      } else if (checkboxNumber == 2) {
        _checkbox2 = value;
        _checkbox1 = !value;
      }
    });
  }

  GlobalKey _arrowKey = GlobalKey();
  Color _arrowColor = Colors.red;
  Offset _arrowPosition = Offset(0.0, 0.0);
  bool _isDragging = false;

  void _startDragging(BuildContext context) {
    setState(() {
      _isDragging = true;
    });
  }

  void _stopDragging(BuildContext context) {
    setState(() {
      _isDragging = false;
      // _arrowPosition =  details.
    });
  }

  void _dragging(BuildContext context, DragUpdateDetails details) {
    // Add custom logic while dragging, if needed
    setState(() {
      _arrowPosition = details.localPosition - Offset(20, 170);
    });
  }

  bool imageSaved = false;
  List<String> _images = [];
  int count = 1;
  Future<String> _saveEditedImage() async {
    RenderRepaintBoundary boundary =
        _arrowKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 1.0);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) return '';

    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/edited_image_${count}.png';
    File(imagePath).writeAsBytesSync(byteData!.buffer.asUint8List());
    _images.add(imagePath);
    // print(_images);
    setState(() {
      count++;
      imageSaved = true;
    });
    return imagePath;
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

  save() async {
    String imagePath = await _saveEditedImage();
    dynamic _store = await {
      // 'images': imagePath.toString(),
      'premises': _checkbox1 ? 'internal' : 'external',
      'location': _locationController.text.toString(),
      'cleaning': _CleaningIssueController.text.toString(),
      'structural': _structuralIssueController.text.toString(),
      'access': _accessIssueController.text.toString(),
      'infestation': _infestationController.text.toString(),
      'obervations': _observationController.text.toString(),
      'preventive': _preventiveController.text.toString(),
      'curative': _curativeController.text.toString(),
      'review_date': reviewdateinput.text.toString(),
      'completion_date': completiondateinput.text.toString()
    };

    await resetStrings();
    Navigator.pop(
      context,
      {'store': _store, 'image': imagePath.toString()},
    );
  }

  resetStrings() {
    _image = null;
    imageselected = false;
    imageSaved = false;
    _checkbox1 = false;
    _checkbox2 = false;
    reviewdateinput.text = "";
    completiondateinput.text = "";
    _locationController.text = "";
    _CleaningIssueController.text = "";
    _structuralIssueController.text = "";
    _accessIssueController.text = "";
    _infestationController.text = "";
    _observationController.text = "";
    _preventiveController.text = "";
    _curativeController.text = "";
  }
}
