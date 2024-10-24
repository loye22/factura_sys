import 'dart:convert';
import 'package:factura_sys/models/intrariService_Model.dart'; // Adjust import as necessary
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

class IntrariProvider with ChangeNotifier {
  List<IntrariService_Model> _intrariList = [];
  late IntrariServiceDataSource _intrariDataSources;

  IntrariServiceDataSource get intrariDataSources => _intrariDataSources;

  bool get hasData => _intrariList.isNotEmpty;

  IntrariProvider() {
    fetchIntrariFromAppSheet();
  }

  Future<void> fetchIntrariFromAppSheet() async {
    if (_intrariList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Intrari Service Auto/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR', // Use your actual key
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
        List<IntrariService_Model> intrariListHelper = [];

        for (var item in data) {
          IntrariService_Model intrare = IntrariService_Model(
            idIntrareService: item['ID Intrare Service'] ?? 'NOTFOUND',
            serieSasiu: item['Serie Sasiu'] ?? 'NOTFOUND',
            numarInmatriculare: item['Numar Inmatriculare'] ?? 'NOTFOUND',
            marca: item['Marca'] ?? 'NOTFOUND',
            model: item['Model'] ?? 'NOTFOUND',
            cuiService: item['CUI Service'] ?? 'NOTFOUND',
            denumireService: item['Denumire Service'] ?? 'NOTFOUND',
            motiv: item['Motiv'] ?? 'NOTFOUND',
            dataDeLa: item['Data De la']  ?? 'NOTFOUND',
            dataPanaLa: item['Data Pana la']  ?? 'NOTFOUND',
            idFactura: item['ID Factura'] ?? 'NOTFOUND',
            totalPlata: double.tryParse(item['Total Plata'] ?? '0') ?? 0.0,
            statusPlata: item['Status Plata'] ?? 'NOTFOUND',
            constatare: item['Constatare'] ?? 'NOTFOUND',
            fisierDeviz: item['Fisier Deviz'] ?? 'NOTFOUND',
          );
          intrariListHelper.add(intrare);
        }

        _intrariList = intrariListHelper;
        _intrariDataSources = IntrariServiceDataSource(intrariServices: _intrariList);
        notifyListeners();
      } else {
        print('Failed to load entries: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching entries from AppSheet API: $e');
    }
  }

  Future<void> refreshData() async {
    _intrariList = [];
    await fetchIntrariFromAppSheet();
  }

  Future<void> addIntrare({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'IntrariService/Action';
    final headers = {
      'ApplicationAccessKey': 'YOUR_ACCESS_KEY', // Use your actual key
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "ID Intrare Service": data['idIntrareService'],
          "Serie Sasiu": data['serieSasiu'],
          "Numar Inmatriculare": data['numarInmatriculare'],
          "Marca": data['marca'],
          "Model": data['model'],
          "CUI Service": data['cuiService'],
          "Denumire Service": data['denumireService'],
          "Motiv": data['motiv'],
          "Data De la": formatDate(data['dataDeLa']),
          "Data Pana la": formatDate(data['dataPanaLa']),
          "ID Factura": data['idFactura'],
          "Total Plata": data['totalPlata']?.toDouble() ?? 0.0,
          "Status Plata": data['statusPlata'],
          "Constatare": data['constatare'],
          "Fisier Deviz": data['fisierDeviz'],
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
        final responseData = jsonDecode(response.body);
        print('AppSheet response: $responseData');

        IntrariService_Model newIntrare = IntrariService_Model(
          idIntrareService: data['idIntrareService'],
          serieSasiu: data['serieSasiu'],
          numarInmatriculare: data['numarInmatriculare'],
          marca: data['marca'],
          model: data['model'],
          cuiService: data['cuiService'],
          denumireService: data['denumireService'],
          motiv: data['motiv'],
          dataDeLa: data['dataDeLa'],
          dataPanaLa: data['dataPanaLa'],
          idFactura: data['idFactura'],
          totalPlata: data['totalPlata']?.toDouble() ?? 0.0,
          statusPlata: data['statusPlata'],
          constatare: data['constatare'],
          fisierDeviz: data['fisierDeviz'],
        );

        _intrariList.add(newIntrare);
        _intrariDataSources = IntrariServiceDataSource(intrariServices: _intrariList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Entitate adăugată cu succes!",
          ),
        );
      } else {
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

  String formatDate(DateTime? date) {
    return date?.toIso8601String() ?? '';
  }
}
