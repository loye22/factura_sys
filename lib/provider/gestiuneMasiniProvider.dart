import 'dart:convert';
import 'package:factura_sys/models/gestinueMasini_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class gestinueMasiniProvider with ChangeNotifier {
  List<gestinueMasini_Model> _masiniList = [];
  late gestinueMasiniDataSource _masiniDataSources;

  // Getter for masiniDataSource
  gestinueMasiniDataSource get masiniDataSources => _masiniDataSources;

  // Check if data has already been fetched
  bool get hasData => _masiniList.isNotEmpty;

  gestinueMasiniProvider() {
    fetchMasiniFromAppSheet();
  }

  Future<void> fetchMasiniFromAppSheet() async {
    if (_masiniList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url =
          staticVar.urlAPI + 'Parc Auto/Action'; // Update endpoint as needed
      final headers = {
        'ApplicationAccessKey':
            'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Properties": {}, "Rows": []});

      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<gestinueMasini_Model> masiniListHelper = [];

        for (var item in data) {
          // staticVar.printMap(item);

          gestinueMasini_Model masina = gestinueMasini_Model(
            serieSasiu: item['Serie Sasiu'] ?? 'NOTFOUND',
            cuiProprietar: item['CUI Proprietar'] ?? 'NOTFOUND',
            proprietar: item['Propietar'] ?? 'NOTFOUND',
            comodat: item['Comodat'] ?? 'NOTFOUND',
            numarInmatricular: item['Numar Inmatricular'] ?? 'NOTFOUND',
            marcaMasina: item['Marca Masina'] ?? 'NOTFOUND',
            modelModel: item['Model Model'] ?? 'NOTFOUND',
            anul: item['Anul'] ?? 'NOTFOUND',
            utilizator: item['Utilizator'] ?? 'NOTFOUND',
            kilometraj: item['Kilometraj'] ?? "0.0",
            tipCombustibil: item['Tip Combustibil'] ?? 'NOTFOUND',
            valabilitateRCA:
                staticVar.convertStringToDate(item['Valabilitate RCA']),
            valabilitateITP:
                staticVar.convertStringToDate(item['Valabilitate ITP']),
            valabilitateROVINIETA:
                staticVar.convertStringToDate(item['Valabilitate ROVINIETA']),
            valabilitateCASCO:
                staticVar.convertStringToDate(item['Valabilitate CASCO']),
            responsabil: item['Responsabil'] ?? 'NOTFOUND',
            valoareAchizitie: item['Valoare Achizitie'] ?? '0',
            moneda: item['Moneda'] ?? 'NOTFOUND',
            intrariService: item['Intrari Service'] ?? 'NOTFOUND',
            cheltuieliService: item['Cheltuieli Service'] ?? 'NOTFOUND',
          );
          masiniListHelper.add(masina);
        }

        _masiniList = masiniListHelper;
        _masiniDataSources = gestinueMasiniDataSource(masini: _masiniList);
        notifyListeners();
      } else {
        print(
            'Failed to load masini: ${response.reasonPhrase} ${response.body}');
      }
    } catch (e) {
      print('Error fetching masini from AppSheet API: $e');
    }
  }

  Future<void> refreshData() async {
    _masiniList = [];
    await fetchMasiniFromAppSheet();
  }

  // Method to add a new IBAN entity using AppSheet API
  Future<void> addMasina({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'Parc Auto/Action';
    final headers = {
      'ApplicationAccessKey':
          'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [data]
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
        notifyListeners();
        refreshData();
        // Show success message
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Masini adăugată cu succes!",
          ),
        );
      } else {
        // Handle API error response
        print(
            'Failed to add entity: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message:
                "Eroare la adăugarea entității. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding entity: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message:
              "Eroare la adăugarea entității. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
