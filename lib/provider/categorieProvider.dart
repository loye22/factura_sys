import 'dart:convert';
import 'package:factura_sys/models/categorie_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class categorieProvider with ChangeNotifier {
  List<categorie_Model> _categorieList = []; // Holds the categorie data
  late categorieDataSource _categorieDataSources;

  // Getter for categorieDataSource
  categorieDataSource get categorieDataSources => _categorieDataSources;

  // Check if data has already been fetched
  bool get hasData => _categorieList.isNotEmpty;

  categorieProvider() {
    fetchCategorieFromAppSheet();
  }

  Future<void> fetchCategorieFromAppSheet() async {
    // Skip fetching if data is already present
    if (_categorieList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Categorie Tag/Action';
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


        List<categorie_Model> categorieListHelper = [];

        // Assuming that the response is a list of rows
        for (var item in data) {
          categorie_Model categorie = categorie_Model(
            categorieTag: item['Categorie Tag'] ?? 'NOTFOUND',
          );
          categorieListHelper.add(categorie);
        }

        _categorieList = categorieListHelper;
        _categorieDataSources = categorieDataSource(categories: _categorieList);
        notifyListeners();  // Notify UI about changes
      } else {
        print('Failed to load categories: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching categories from AppSheet API: $e');
    }
  }

  // Refresh method to force re-fetching of data
  Future<void> refreshData() async {
    _categorieList = [];
    await fetchCategorieFromAppSheet();
  }

  // Method to add a new category using AppSheet API
  Future<void> addCategorie({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'Categorie Tag/Action';
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "Categorie Tag": data['categorieTag'],
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
        final responseData = jsonDecode(response.body);
        print('AppSheet response: $responseData');

        // Create the categorie_Model object
        categorie_Model newCategorie = categorie_Model(
          categorieTag: data['categorieTag'],
        );

        _categorieList.add(newCategorie);  // Add to local list
        _categorieDataSources = categorieDataSource(categories: _categorieList);
        notifyListeners();

        // Show success message
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Categorie adăugată cu succes!",
          ),
        );
      } else {
        print('Failed to add categorie: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea categoriei. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding categorie: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea categoriei. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
