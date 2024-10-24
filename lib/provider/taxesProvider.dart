import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:factura_sys/models/taxes_Model.dart';
import 'package:factura_sys/models/staticVar.dart';

class TaxesProvider with ChangeNotifier {
  List<Taxes_Model> _taxesList = []; // Holds the taxes data
  late TaxesDataSource _taxesDataSource;

  // Getter for TaxesDataSource
  TaxesDataSource get taxesDataSource => _taxesDataSource;

  // Check if data has already been fetched
  bool get hasData => _taxesList.isNotEmpty;

  TaxesProvider() {
    fetchTaxesFromAppSheet();
  }

  Future<void> fetchTaxesFromAppSheet() async {
    if (_taxesList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Taxe/Action';
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
        final List<dynamic> data = jsonDecode(response.body);

        List<Taxes_Model> taxesListHelper = [];

        for (var item in data) {
          Taxes_Model tax = Taxes_Model(
            procentTaxa: item['Procent Taxa'] ?? 'NOTFOUND',
            tip: item['Tip'] ?? 'NOTFOUND',
            denumire: item['Denumire'] ?? 'NOTFOUND',
          );
          taxesListHelper.add(tax);
        }

        _taxesList = taxesListHelper;
        _taxesDataSource = TaxesDataSource(taxes: _taxesList);
        notifyListeners();  // Notify UI about changes
      } else {
        print('Failed to load taxes: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching taxes from AppSheet API: $e');
    }
  }

  Future<void> refreshData() async {
    _taxesList = [];
    await fetchTaxesFromAppSheet();
  }

  Future<void> addTax({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'Taxe/Action';
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "Procent Taxa": data['procentTaxa'],
          "Tip": data['tip'],
          "Denumire": data['denumire'],
        }
      ]
    };

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('AppSheet response: $responseData');

        Taxes_Model newTax = Taxes_Model(
          procentTaxa: data['procentTaxa'],
          tip: data['tip'],
          denumire: data['denumire'],
        );

        _taxesList.add(newTax);  // Add to local list
        _taxesDataSource = TaxesDataSource(taxes: _taxesList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Taxă adăugată cu succes!",
          ),
        );
      } else {
        print('Failed to add tax: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea taxei. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding tax: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea taxei. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
