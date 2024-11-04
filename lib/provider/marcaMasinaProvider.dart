import 'dart:convert';
import 'package:factura_sys/models/marcaMasina_Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:factura_sys/models/staticVar.dart';


class MarcaMasinaProvider with ChangeNotifier {
  List<marcaMasina_Model> _marcaMasinaList = []; // Holds the car brand data
  late marcaMasinaDataSource _marcaMasinaDataSourcee;

  // Getter for marcaMasinaDataSource
  marcaMasinaDataSource get marcaMasinaDataSourcee => _marcaMasinaDataSourcee;

  // Getter for _marcaMasinaList
  List<marcaMasina_Model> get marcaMasinaList => _marcaMasinaList;

  // Check if data has already been fetched
  bool get hasData => _marcaMasinaList.isNotEmpty;

  MarcaMasinaProvider() {
    fetchMarcaMasinaFromAppSheet();
  }

  Future<void> fetchMarcaMasinaFromAppSheet() async {
    if (_marcaMasinaList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Marca Masina/Action'; // Adjusted to reflect the new API endpoint
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

        List<marcaMasina_Model> marcaMasinaListHelper = [];

        for (var item in data) {
          marcaMasina_Model marcaMasina = marcaMasina_Model(
            marcaMasina: item['Marca Masina'] ?? 'NOTFOUND', // Adjusted key according to your model
          );
          marcaMasinaListHelper.add(marcaMasina);
        }

        _marcaMasinaList = marcaMasinaListHelper;
        _marcaMasinaDataSourcee = marcaMasinaDataSource(marca: _marcaMasinaList);
        notifyListeners();
      } else {
        print('Failed to load car brands: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching car brands from AppSheet API: $e');
    }
  }

  Future<void> addMarcaMasina({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    // not tested yet
    return ;
    final String url = staticVar.urlAPI + 'Marca Masina/Action'; // Adjusted to reflect the new API endpoint
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
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
        marcaMasina_Model newMarcaMasina = marcaMasina_Model(
          marcaMasina: data['marcaMasina'], // Adjusted key according to your model
        );

        _marcaMasinaList.add(newMarcaMasina);
        _marcaMasinaDataSourcee = marcaMasinaDataSource(marca: _marcaMasinaList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Marca mașinii adăugată cu succes!", // Translated message
          ),
        );
      } else {
        print('Failed to add car brand: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea mărcii. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding car brand: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea mărcii. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
