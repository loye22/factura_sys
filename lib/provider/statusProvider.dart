import 'dart:convert';
import 'package:factura_sys/models/status_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class statusProvider with ChangeNotifier {
  List<status_Model> _statusList = []; // Holds the status data
  late statusDataSource _statusDataSources;

  // Getter for statusDataSource
  statusDataSource get statusDataSources => _statusDataSources;

  // Check if data has already been fetched
  bool get hasData => _statusList.isNotEmpty;

  statusProvider() {
    fetchStatusFromAppSheet();
  }

  Future<void> fetchStatusFromAppSheet() async {
    // Skip fetching if data is already present
    if (_statusList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Status/Action';
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

        List<status_Model> statusListHelper = [];

        // Assuming that the response is a list of rows
        for (var item in data) {
          status_Model status = status_Model(
            status: item['Status'] ?? 'NOTFOUND',
            univers: item['Univers'] ?? 'NOTFOUND',
          );
          statusListHelper.add(status);
        }

        _statusList = statusListHelper;
        _statusDataSources = statusDataSource(statuses: _statusList);
        notifyListeners();  // Notify UI about changes
      } else {
        print('Failed to load statuses: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching statuses from AppSheet API: $e');
    }
  }

  // Refresh method to force re-fetching of data
  Future<void> refreshData() async {
    _statusList = [];
    await fetchStatusFromAppSheet();
  }

  // Method to add a new status using AppSheet API
  Future<void> addStatus({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'Status/Action';
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "Status": data['status'],
          "Univers": data['univers'],
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

        // Create the status_Model object
        status_Model newStatus = status_Model(
          status: data['status'],
          univers: data['univers'],
        );

        // Notify listeners (UI update logic)
        _statusList.add(newStatus);  // Add to local list
        _statusDataSources = statusDataSource(statuses: _statusList);
        notifyListeners();

        // Show success message
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Status adăugat cu succes!",
          ),
        );
      } else {
        print('Failed to add status: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea statusului. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding status: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea statusului. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
