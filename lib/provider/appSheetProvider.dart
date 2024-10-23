import 'package:factura_sys/models/entitati_Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class appsheetProvider with ChangeNotifier {
  List<entitati_Model> _entitatiList = [];
  late entitatiDataSource _entitatiDataSources;

  // Getter for entitatiDataSource
  entitatiDataSource get entitatiDataSources => _entitatiDataSources;

  // Check if data has already been fetched
  bool get hasData => _entitatiList.isNotEmpty;

  appsheetProvider() {
    fetchEntitatiFromAppSheet();
  }

  Future<void> fetchEntitatiFromAppSheet() async {
    //const String apiUrl = 'https://api.appsheet.com/api/v2/apps/4c08c5a4-2052-4439-9fb1-579d62d2eae0/tables/Entitati/data';


      const String apiUrl = 'https://www.appsheet.com/api/v2/apps/4c08c5a4-2052-4439-9fb1-579d62d2eae0/tables/Entitati/Action?applicationAccessKey=V2-SUh5B-9VbT9-JZwIh-PoPQU-mntnY-AtM5n-DH4tw-nRfbT';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),

      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print(data);  // Print the data for debugging
      } else {
        print('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Refresh method to force re-fetching
  Future<void> refreshData() async {
    _entitatiList = [];  // Clear cache
    await fetchEntitatiFromAppSheet();  // Fetch fresh data
  }

  // Method to add a new entity (depends on the AppSheet API)
  Future<void> addEntitate({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    try {
      const String apiUrl = 'YOUR_APPSHEET_ADD_URL'; // The URL to add data

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse response and add locally if needed
        entitati_Model newEntitate = entitati_Model(
          docId: '',  // Set to the response's new ID if returned
          denumire: data['denumire'] ?? '',
          tip: data['tip'] ?? '',
          cuiEntitate: data['cui'] ?? '',
          timestamp: DateTime.now(),
          userEmail: data['userEmail'] ?? "NOTFOUND",
        );

        _entitatiList.add(newEntitate);
        _entitatiDataSources = entitatiDataSource(orders: _entitatiList);
        notifyListeners();

        // Show success message
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Entitate adăugată cu succes!",
          ),
        );
      } else {
        print('Error adding entity to AppSheet API. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding entity: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea entității. $e",
        ),
      );
    }
  }
}
