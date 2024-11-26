import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:factura_sys/models/ModedaModel.dart';

class ModedaProvider with ChangeNotifier {
  List<ModedaModel> _modedaList = []; // Holds the data for Modeda
  late ModedaDataSource _modedaDataSource;

  // Getter for ModedaDataSource
  ModedaDataSource get modedaDataSource => _modedaDataSource;

  // Getter for _modedaList
  List<ModedaModel> get modedaList => _modedaList;

  // Check if data has already been fetched
  bool get hasData => _modedaList.isNotEmpty;

  ModedaProvider() {
    fetchModedaFromAppSheet();
  }

  Future<void> fetchModedaFromAppSheet() async {
    if (_modedaList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Moneda/Action'; // Adjusted to reflect the new API endpoint
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

        List<ModedaModel> modedaListHelper = [];

        for (var item in data) {
          ModedaModel modeda = ModedaModel(
            modeda: item['Moneda'] ?? 'NOTFOUND', // Adjusted key according to your model
          );
          modedaListHelper.add(modeda);
        }

        _modedaList = modedaListHelper;
        _modedaDataSource = ModedaDataSource(modedas: _modedaList);
        notifyListeners();
      } else {
        print('Failed to load Modeda: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching Modeda from AppSheet API: $e');
    }
  }

  Future<void> addModeda({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'Modeda/Action'; // Adjusted to reflect the new API endpoint
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "Modeda": data['modeda'], // Adjusted key according to your model
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ModedaModel newModeda = ModedaModel(
          modeda: data['modeda'], // Adjusted key according to your model
        );

        _modedaList.add(newModeda);
        _modedaDataSource = ModedaDataSource(modedas: _modedaList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Modeda adăugată cu succes!",
          ),
        );
      } else {
        print('Failed to add Modeda: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea modedei. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding Modeda: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea modedei. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
