import 'dart:convert';
import 'package:factura_sys/models/taguri_Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:factura_sys/models/staticVar.dart';

class TaguriProvider with ChangeNotifier {
  List<Taguri_Model> _taguriList = []; // Holds the tag data
  late TaguriDataSource _taguriDataSource;

  // Getter for taguriDataSource
  TaguriDataSource get taguriDataSource => _taguriDataSource;

  // Check if data has already been fetched
  bool get hasData => _taguriList.isNotEmpty;

  TaguriProvider() {
    fetchTaguriFromAppSheet();
  }

  Future<void> fetchTaguriFromAppSheet() async {
    if (_taguriList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Taguri/Action';
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

        List<Taguri_Model> taguriListHelper = [];

        for (var item in data) {
          Taguri_Model tag = Taguri_Model(
            tag: item['Tag'] ?? 'NOTFOUND',
          );
          taguriListHelper.add(tag);
        }

        _taguriList = taguriListHelper;
        _taguriDataSource = TaguriDataSource(tags: _taguriList);
        notifyListeners();
      } else {
        print('Failed to load tags: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching tags from AppSheet API: $e');
    }
  }

  Future<void> addTag({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'Taguri/Action';
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "Tag": data['tag'],
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
        Taguri_Model newTag = Taguri_Model(
          tag: data['tag'],
        );

        _taguriList.add(newTag);
        _taguriDataSource = TaguriDataSource(tags: _taguriList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Tag adăugat cu succes!",
          ),
        );
      } else {
        print('Failed to add tag: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea tagului. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding tag: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea tagului. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
