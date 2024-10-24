import 'dart:convert';

import 'package:factura_sys/models/concedii_Model.dart';  // Make sure this path is correct
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

class concediiProvider with ChangeNotifier {
  List<concedii_Model> _concediiList = []; // Make this nullable
  late concediiDataSource _concediiDataSources;

  // Getter for concediiDataSource
  concediiDataSource get concediiDataSources => _concediiDataSources;

  // Check if data has already been fetched
  bool get hasData => _concediiList != null && _concediiList.isNotEmpty;

  concediiProvider() {
    fetchConcediiFromAppSheet();
  }

  Future<void> fetchConcediiFromAppSheet() async {
    // Skip fetching if data is already present
    if (_concediiList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Concedii/Action'; // Adjust the endpoint as necessary
      final headers = {
        'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Find",
        "Properties": {},
        "Rows": []
      });

      // Make the API call
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        // Parse the response body as a List
        final List<dynamic> data = jsonDecode(response.body);

        List<concedii_Model> concediiListHelper = [];

        // Assuming that the response is a list of rows
        for (var item in data) {
          print(item['Data De la'].toString() + "-- "+  item['Data De la'].runtimeType.toString());
          concedii_Model concediu = concedii_Model(
            idConcediu: item['ID Concediu'] ?? 'NOTFOUND',
            idAngajat: item['ID Angajat'] ?? 'NOTFOUND',
            numeAngajat: item['Nume Angajat'] ?? 'NOTFOUND',
            cuiAngajator: item['CUI Angajator'] ?? 'NOTFOUND',
            denumireFirma: item['Denumire Firma'] ?? 'NOTFOUND',
            tip: item['Tip'] ?? 'NOTFOUND',
            dataDeLa: item['Data De la'].toString() ,//item['Data De la'],
            numarZile: int.tryParse(item['Număr Zile'] ?? '0') ?? 0,
            aprobat: item['Aprobat'] == 'Y',  // Convert 'Y'/'N' to boolean
            perioada: item['Perioada'] ?? 'NOTFOUND',
            dataPanaLa: item['Data Pana la'] ?? 'NOTFOUND',


          );
          concediiListHelper.add(concediu);
        }

        _concediiList = concediiListHelper;
        _concediiDataSources = concediiDataSource(concedii: _concediiList);
        notifyListeners();  // Notify UI about changes
      } else {
        print('Failed to load concedii: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching concedii from AppSheet API: $e');
      // Handle error (e.g., show a SnackBar, etc.)
    }
  }

  // Refresh method if you want to force re-fetch
  Future<void> refreshData() async {
    _concediiList = []; // Clear cache
    await fetchConcediiFromAppSheet(); // Fetch fresh data
  }

  // Method to add a new concediu entity using AppSheet API
  Future<void> addConcediu({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {}

  // Convert DateTime to ISO 8601 format strings
  String? formatDate(DateTime? date) {
    return date?.toIso8601String();
  }
}
