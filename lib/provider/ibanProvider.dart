import 'dart:convert';

import 'package:factura_sys/models/iban_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http ;

class ibanProvider with ChangeNotifier {
  List<iban_Model> _ibanList = []; // Make this nullable
  late ibanDataSource _ibanDataSources;

  // Getter for entitatiDataSource
  ibanDataSource get ibanDataSources => _ibanDataSources;

  // Check if data has already been fetched
  bool get hasData => _ibanList != null && _ibanList!.isNotEmpty;


  ibanProvider() {
    fetchIbanFromAppSheet();
  }

  Future<void> fetchIbanFromAppSheet() async {
    // Skip fetching if data is already present
    if (_ibanList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'IBAN/Action'  ;
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

        List<iban_Model> ibanListHelper = [];

        // Assuming that the response is a list of rows
        for (var item in data) {
          iban_Model iban = iban_Model(
            iban: item['IBAN'] ?? 'NOTFOUND',
            banca: item['Banca'] ?? 'NOTFOUND',
            cuiTitular: item['CUI Titular'] ?? 'NOTFOUND',
            denumireTitular: item['Denumire Titular'] ?? 'NOTFOUND',
            moneda: item['Moneda'] ?? 'NOTFOUND',
            contPropriu: item['Cont Propriu'] == 'Y',  // Convert 'Y'/'N' to boolean
            soldInitial: double.tryParse(item['Sold Initial'] ?? '0') ?? 0.0,
            soldCurent: double.tryParse(item['Sold Curent'] ?? '0') ?? 0.0,
            dataPrimaTranzactieExtras: item['Data Prima Tranzactie Extras'] != null
                ? DateTime.tryParse(item['Data Prima Tranzactie Extras'])
                : null,
            dataUltimaTranzactie: item['Data Ultima tranzactie'] != null
                ? DateTime.tryParse(item['Data Ultima tranzactie'])
                : null,
            docId: item['_RowNumber'] ?? '',
            timestamp: DateTime.now(),  // Placeholder for timestamp; update as needed
            userEmail: 'NOTFOUND',  // Placeholder; update as needed
          );
          ibanListHelper.add(iban);
        }

        _ibanList = ibanListHelper;
        _ibanDataSources = ibanDataSource(ibans: _ibanList);
        notifyListeners();  // Notify UI about changes
      } else {
        print('Failed to load IBANs: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching IBANs from AppSheet API: $e');
      // Handle error (e.g., show a SnackBar, etc.)
    }



  }

  // Refresh method if you want to force re-fetch
  Future<void> refreshData() async {
    _ibanList = []; // Clear cache
    await fetchIbanFromAppSheet(); // Fetch fresh data
  }



// Method to add a new IBAN entity using AppSheet API
  Future<void> addIban({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'IBAN/Action';
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "IBAN": data['iban'],
          "Banca": data['banca'],
          "CUI Titular": data['cuiTitular'],
          "Denumire Titular": data['denumireTitular'],
          "Moneda": data['moneda'],
          "Cont Propriu": data['contPropriu'],
          "Data Prima Tranzactie Extras":formatDate(data['dataPrimaTranzactieExtras'] ?? DateTime(1800)) ,
          "Sold Initial": data['soldInitial']?.toDouble() ?? 0.0,
          "Data Ultima Tranzactie":formatDate(data['dataUltimaTranzactie']?? DateTime(1800)) ,
          "Sold Curent": data['soldCurent']?.toDouble() ?? 0.0,
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

        // Create the iban_Model object
        iban_Model newIBAN = iban_Model(
          docId: "generated-doc-id-from-response", // Assign docId based on response if available
          iban: data['iban'],
          banca: data['banca'],
          cuiTitular: data['cuiTitular'],
          denumireTitular: data['denumireTitular'],
          moneda: data['moneda'],
          contPropriu: data['contPropriu'],
          soldInitial: data['soldInitial']?.toDouble() ?? 0.0,
          soldCurent: data['soldCurent']?.toDouble() ?? 0.0,
          userEmail: data['userEmail'],
          timestamp: DateTime.now(),  // Use the current timestamp if needed
          dataPrimaTranzactieExtras: data['dataPrimaTranzactieExtras'],
          dataUltimaTranzactie: data['dataUltimaTranzactie'],
        );

        // Notify listeners (UI update logic here if necessary)
        _ibanList.add(newIBAN);  // Add to local list if you are managing local state
        _ibanDataSources = ibanDataSource(ibans: _ibanList!);  // Updating the data source
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

  // Convert DateTime to ISO 8601 format strings
  String? formatDate(DateTime? date) {
    return date?.toIso8601String();
  }


}
