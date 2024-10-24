import 'dart:convert';
import 'package:factura_sys/models/gestinueMasini_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

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
      final url = staticVar.urlAPI + 'Parc Auto/Action'; // Update endpoint as needed
      final headers = {
        'ApplicationAccessKey':  'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
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
            valabilitateRCA: item['Valabilitate RCA'] ?? 'NOTFOUND',
            valabilitateITP: item['Valabilitate ITP'] ?? 'NOTFOUND',
            valabilitateROVINIETA: item['Valabilitate ROVINIETA'] ?? 'NOTFOUND',
            valabilitateCASCO: item['Valabilitate CASCO'] ?? 'NOTFOUND',
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
        print('Failed to load masini: ${response.reasonPhrase } ${response.body}');
      }
    } catch (e) {
      print('Error fetching masini from AppSheet API: $e');
    }
  }

  Future<void> refreshData() async {
    _masiniList = [];
    await fetchMasiniFromAppSheet();
  }


}
