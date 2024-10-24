import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:factura_sys/models/polite_Model.dart'; // Import your polite_Model here
import 'package:factura_sys/models/staticVar.dart';

class politeProvider with ChangeNotifier {
  List<polite_Model> _politeList = []; // Make this nullable
  late politeDataSource _politeDataSources;

  // Getter for politeDataSource
  politeDataSource get politeDataSources => _politeDataSources;

  // Check if data has already been fetched
  bool get hasData => _politeList.isNotEmpty;

  politeProvider() {
    fetchPoliteFromAppSheet();
  }

  Future<void> fetchPoliteFromAppSheet() async {
    // Skip fetching if data is already present
    if (_politeList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Polite Asigurari/Action';
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

        List<polite_Model> politeListHelper = [];

        // Assuming that the response is a list of rows
        for (var item in data) {
          polite_Model polite = polite_Model(
            idPolitaAsigurari: item['ID Polita Asigurari'] ?? 'NOTFOUND',
            tipPolita: item['Tip Polita'] ?? 'NOTFOUND',
            serieSasiu: item['Serie Sasiu'] ?? 'NOTFOUND',
            numarInmatriculare: item['Numar Inmatriculare'] ?? 'NOTFOUND',
            marca: item['Marca'] ?? 'NOTFOUND',
            model: item['Model'] ?? 'NOTFOUND',
            cuiFurnizor: item['CUI Furnizor'] ?? 'NOTFOUND',
            numeFurnizor: item['Nume Furnizor'] ?? 'NOTFOUND',
            valabilitateDeLa: item['Valabilitate De la'] ?? 'NOTFOUND',
            valabilitatePanaLa: item['Valabilitate Pana la'] ?? 'NOTFOUND',
            idFactura: item['ID Factura'] ?? 'NOTFOUND',
            totalPlata: double.tryParse(item['Total Plata'].toString()) ?? 0.0,
            statusPlata: item['Status Plata'] ?? 'NOTFOUND',
            fisierPolita: item['Fisier Polita'] ?? 'NOTFOUND',
          );
          politeListHelper.add(polite);
        }

        _politeList = politeListHelper;
        _politeDataSources = politeDataSource(polites: _politeList);
        notifyListeners();  // Notify UI about changes
      } else {
        print('Failed to load polite: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching polite from AppSheet API: $e');
      // Handle error (e.g., show a SnackBar, etc.)
    }
  }

  // Refresh method if you want to force re-fetch
  Future<void> refreshData() async {
    _politeList = []; // Clear cache
    await fetchPoliteFromAppSheet(); // Fetch fresh data
  }


  // Convert DateTime to ISO 8601 format strings
  String? formatDate(DateTime? date) {
    return date?.toIso8601String();
  }
}
