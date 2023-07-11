import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

class apiIntegration {
  //=======================GET AUDITED PERSON LIST =================================
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

  //=============== LOCATION LIST =======================

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

  // =====================CLEANING ISSEUE LIST====================

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

  //====================SRUCTURAL ISSUE LIST ==============================
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

  //======================ACCESS ISSUE LIST=============================
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

  //=======================INFESTATION LIST=============================
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

  //=======================OBSERVTION LIST===============================
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

  //=====================PREVENTION LIST===============================
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

  //=========================CURATIVE LIST==========================
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
}
