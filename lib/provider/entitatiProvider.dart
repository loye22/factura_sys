import 'dart:convert';
import 'package:factura_sys/models/entitati_Model.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:factura_sys/models/staticVar.dart';

class EntitatiProvider with ChangeNotifier {
  List<entitati_Model> _entitatiList = []; // You can make this nullable if needed.
  late entitatiDataSource _entitatiDataSources;

  // Getter for entitatiDataSource
  entitatiDataSource get entitatiDataSources => _entitatiDataSources;

  // Check if data has already been fetched
  bool get hasData => _entitatiList != null && _entitatiList.isNotEmpty;

  // Getter for _entitatiList
  List<entitati_Model> get entitatiList => _entitatiList;



  // Add a new list to store the 'Tipuri' data
  List<String> _tipuriList = [];

  // Getter for the list of 'Tipuri'
  List<String> get tipuriList => _tipuriList;

  EntitatiProvider() {
    fetchEntitatiFromAppSheet(); // Now calling from AppSheet
    fetchTipuriFromAppSheet(); // Fetch 'Tipuri' data on initialization
  }

  // Fetch Entitati data from AppSheet API
  Future<void> fetchEntitatiFromAppSheet() async {
    // Skip fetching if data is already present
    if (_entitatiList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API for entitati data...");

    try {
      final url = staticVar.urlAPI + 'Entitati/Action'; // Adjust the URL as per your API structure
      final headers = {
        'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR', // Replace with valid key
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

        List<entitati_Model> entitatiListHelper = [];

        // Assuming that the response is a list of rows
        for (var item in data) {
          entitati_Model entitate = entitati_Model(
            docId: item['_RowNumber'] ?? '',  // Replace with appropriate field if available
            denumire: item['Denumire'] ?? 'NOTFOUND',
            tip: item['Tip'] ?? 'NOTFOUND',
            cuiEntitate: item['CUI Entitate'] ?? 'NOTFOUND',
            timestamp: DateTime.now(), // Placeholder for timestamp; update as needed
            userEmail: 'NOTFOUND', // Placeholder; update as needed
          );
          entitatiListHelper.add(entitate);
        }

        _entitatiList = entitatiListHelper;
        _entitatiDataSources = entitatiDataSource(orders: _entitatiList);
        notifyListeners(); // Notify UI about changes
      } else {
        print('Failed to load entitati: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching entitati from AppSheet API: $e');
      // Handle error (e.g., show a SnackBar, etc.)
    }
  }

  // Refresh method if you want to force re-fetch
  Future<void> refreshData() async {
    _entitatiList = []; // Clear cache
    await fetchEntitatiFromAppSheet(); // Fetch fresh data
  }

  // Method to add a new entity using AppSheet API
  Future<void> addEntitate({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {



    final String url = staticVar.urlAPI + 'Entitati/Action';
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "Denumire": data['denumire'],
          "Tip": data['tip'],
          "CUI Entitate": data['cui'],
        }
      ]
    };

    try {
      // Sending POST request to AppSheet API
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Parse the response if needed
        final responseData = jsonDecode(response.body);
        print('AppSheet response: $responseData');

        // Create the entitati_Model object
        entitati_Model newEntitate = entitati_Model(
          docId: "generated-doc-id-from-response", // Assign docId based on response if available
          denumire: data['denumire'],
          tip: data['tip'],
          cuiEntitate: data['cui'],
          timestamp: DateTime.now(), // Use the current timestamp if needed
          userEmail: 'userEmail_placeholder', // Replace with actual userEmail if necessary
        );

        // Notify listeners (UI update logic here if necessary)
        _entitatiList.add(newEntitate); // Add to local list if managing local state
        _entitatiDataSources = entitatiDataSource(orders: _entitatiList); // Update the data source
        notifyListeners();

        // Show success message
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Entitate adăugată cu succes!",
          ),
        );
      } else {
        // Handle API error response
        print('Failed to add entity: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea entității. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding entity: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea entității. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }


  // Fetch 'Tipuri' data from AppSheet API
  Future<void> fetchTipuriFromAppSheet() async {
    try {
      final url = staticVar.urlAPI + 'Tipuri/Action'; // Adjust the URL to fetch from 'Tipuri' table
      final headers = {
        'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Find",
        "Properties": {},
        "Rows": []
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Clear existing list to avoid duplicates
        List<String> tipuriListHelper = [];

        // Extract 'Tip' from each row and add to list
        for (var item in data) {
          String tip = item['Tip'] ?? 'NOTFOUND';
          tipuriListHelper.add(tip);
        }

        _tipuriList = tipuriListHelper;
        notifyListeners(); // Notify UI about changes
      } else {
        print('Failed to load tipuri: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching tipuri from AppSheet API: $e');
    }
  }

  // Refresh method for 'Tipuri'
  Future<void> refreshTipuriData() async {
    _tipuriList = []; // Clear cache
    await fetchTipuriFromAppSheet(); // Fetch fresh data
  }
}



