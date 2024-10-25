import 'dart:convert';
import 'package:factura_sys/models/firmGestiune_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class firmGestiuneProvider with ChangeNotifier {
  List<firmGestiune_Model> _firmList = [];
  late firmGestiuneDataSource _firmDataSource;

  firmGestiuneDataSource get firmDataSource => _firmDataSource;
  bool get hasData => _firmList.isNotEmpty;

  firmGestiuneProvider() {
    fetchFirmsFromAppSheet();
  }

  Future<void> fetchFirmsFromAppSheet() async {
    if (_firmList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }

    try {
      final url = staticVar.urlAPI + 'Firme Gestiune/Action';
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
        List<firmGestiune_Model> firmListHelper = [];

        for (var item in data) {
          firmGestiune_Model firm = firmGestiune_Model(
            cuiFirmaGestiune: item['CUI Firma Gestiune'] ?? 'NOTFOUND',
            denumireFirma: item['Denumire Firma'] ?? 'NOTFOUND',
            certificatPDF: item['Certificat PDF'] ?? 'NOTFOUND',
            administrator: item['Administrator'] ?? 'NOTFOUND',
          );
          firmListHelper.add(firm);
        }

        _firmList = firmListHelper;
        _firmDataSource = firmGestiuneDataSource(firms: _firmList);
        notifyListeners();
      } else {
        print('Failed to load firms: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching firms from AppSheet API: $e');
    }
  }

  Future<void> addFirm({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'FirmGestiune/Action';
    final headers = {
      'ApplicationAccessKey': 'YOUR_API_KEY',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "CUI Firma Gestiune": data['cuiFirmaGestiune'],
          "Denumire Firma": data['denumireFirma'],
          "Certificat PDF": data['certificatPDF'],
          "Administrator": data['administrator'],
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
        firmGestiune_Model newFirm = firmGestiune_Model(
          cuiFirmaGestiune: data['cuiFirmaGestiune'],
          denumireFirma: data['denumireFirma'],
          certificatPDF: data['certificatPDF'],
          administrator: data['administrator'],
        );

        _firmList.add(newFirm);
        _firmDataSource = firmGestiuneDataSource(firms: _firmList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Firmă adăugată cu succes!",
          ),
        );
      } else {
        print('Failed to add firm: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea firmei. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding firm: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea firmei. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
