import 'dart:convert';
import 'package:factura_sys/models/TipuriModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:factura_sys/models/staticVar.dart';

class TipuriProvider with ChangeNotifier {
  List<TipuriModel> _tipuriList = []; // Holds the data for Tipuri
  late TipuriDataSource _tipuriDataSource;

  // Getter for TipuriDataSource
  TipuriDataSource get tipuriDataSource => _tipuriDataSource;

  // Getter for _tipuriList
  List<TipuriModel> get tipuriList => _tipuriList;

  // Check if data has already been fetched
  bool get hasData => _tipuriList.isNotEmpty;

  TipuriProvider() {
    fetchTipuriFromAppSheet();
  }

  Future<void> fetchTipuriFromAppSheet() async {
    if (_tipuriList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API Tipuri");

    try {
      final url = staticVar.urlAPI + 'Tipuri/Action'; // Adjusted to reflect the new API endpoint
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

        List<TipuriModel> tipuriListHelper = [];

        for (var item in data) {
          TipuriModel tipuri = TipuriModel(
            tip: item['Tip'] ?? 'NOTFOUND', // Adjusted key according to your model
            univers: item['Univers'] ?? 'NOTFOUND', // Adjusted key according to your model
          );
          if(item['Univers'] == 'Combustibil'){
            tipuriListHelper.add(tipuri);
          }

        }

        _tipuriList = tipuriListHelper;
        _tipuriDataSource = TipuriDataSource(tipuri: _tipuriList);
        notifyListeners();
      } else {
        print('Failed to load Tipuri: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching Tipuri from AppSheet API: $e');
    }
  }

  Future<void> addTipuri({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    // not tested yet
    return ;
    final String url = staticVar.urlAPI + 'Tipuri/Action'; // Adjusted to reflect the new API endpoint
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "Tip": data['tip'], // Adjusted key according to your model
          "Univers": data['univers'], // Adjusted key according to your model
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
        TipuriModel newTipuri = TipuriModel(
          tip: data['tip'], // Adjusted key according to your model
          univers: data['univers'], // Adjusted key according to your model
        );

        _tipuriList.add(newTipuri);
        _tipuriDataSource = TipuriDataSource(tipuri: _tipuriList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Tip adăugat cu succes!",
          ),
        );
      } else {
        print('Failed to add Tipuri: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea tipului. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding Tipuri: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea tipului. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
