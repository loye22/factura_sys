import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:factura_sys/models/marcaMasina_Model.dart'; // Ensure this imports the new model class
import 'package:factura_sys/models/modelMasinaModel.dart'; // Import your new model here

class modelMasinaProvider with ChangeNotifier {
  List<modelMasinaModel> _modelMasinaList = []; // Holds the car model data
  late modelMasinaDataSource _modelMasinaDataSourcee;

  // Getter for modelMasinaDataSource
  modelMasinaDataSource get modelMasinaDataSourcee => _modelMasinaDataSourcee;

  // Getter for _modelMasinaList
  List<modelMasinaModel> get modelMasinaList => _modelMasinaList;

  // Check if data has already been fetched
  bool get hasData => _modelMasinaList.isNotEmpty;

  modelMasinaProvider() {
    fetchModelMasinaFromAppSheet();
  }

  Future<void> fetchModelMasinaFromAppSheet() async {
    if (_modelMasinaList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Model Masina/Action'; // Adjusted to reflect the new API endpoint
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

        List<modelMasinaModel> modelMasinaListHelper = [];

        for (var item in data) {
          modelMasinaModel modelMasina = modelMasinaModel(
            model: item['Model Model'] ?? 'NOTFOUND', // Adjusted key according to your model
            marcaMasina: item['Marca Masina'] ?? 'NOTFOUND', // Adjusted key according to your model
          );
          modelMasinaListHelper.add(modelMasina);
        }

        _modelMasinaList = modelMasinaListHelper;
        _modelMasinaDataSourcee = modelMasinaDataSource(masini: _modelMasinaList);
        notifyListeners();
      } else {
        print('Failed to load car models: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching car models from AppSheet API: $e');
    }
  }

  Future<void> addModelMasina({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    // not tested yet
    return;

    final String url = staticVar.urlAPI + 'Model Masina/Action'; // Adjusted to reflect the new API endpoint
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "Model": data['model'], // Adjusted key according to your model
          "Marca": data['marcaMasina'], // Adjusted key according to your model
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
        modelMasinaModel newModelMasina = modelMasinaModel(
          model: data['model'], // Adjusted key according to your model
          marcaMasina: data['marcaMasina'], // Adjusted key according to your model
        );

        _modelMasinaList.add(newModelMasina);
        _modelMasinaDataSourcee = modelMasinaDataSource(masini: _modelMasinaList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Modelul mașinii adăugat cu succes!", // Translated message
          ),
        );
      } else {
        print('Failed to add car model: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea modelului. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding car model: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea modelului. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
