import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:factura_sys/models/staticVar.dart';
import 'package:factura_sys/models/angajati_Model.dart'; // Make sure to import your angajati_Model

class AngajatiProvider with ChangeNotifier {
  List<Angajati_Model> _angajatiList = [];
  late AngajatiDataSource _angajatiDataSource;

  AngajatiDataSource get angajatiDataSource => _angajatiDataSource;

  bool get hasData => _angajatiList.isNotEmpty;

  AngajatiProvider() {
    fetchAngajatiFromAppSheet(); // Fetch data on initialization
  }

  Future<void> fetchAngajatiFromAppSheet() async {
    if (_angajatiList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API for angajati data...");

    try {
      final url =
          staticVar.urlAPI + 'Angajati/Action'; // Adjust the URL for Angajati
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
        List<Angajati_Model> angajatiListHelper = [];
        // print(data);

        for (var item in data) {
          //  staticVar.printMap(item);
        //  print(item['Concedii neefectuate pana la 2018-12-31']);
          Angajati_Model angajat = Angajati_Model(
            idAngajat: item['ID Angajat'] ?? 'NOTFOUND',
            cuiAngajator: item['CUI Angajator'] ?? 'NOTFOUND',
            numeAngajator: item['Nume Angajator'] ?? 'NOTFOUND',
            numePrenume: item['Nume Prenume'] ?? 'NOTFOUND',
            functia: item['Functia'] ?? 'NOTFOUND',
            nrContract: item['Nr Contract'] ?? 'NOTFOUND',
            dataContract: item['Data Contract'] ?? "NotFound",
            // dataContract: DateTime.tryParse(item['Data Contract'] ?? '') ??
            //     DateTime.now(),
            ore: item['Ore'] ?? "NotFound",
            salariuBrut: item['Salariu Brut'] ?? "0.0",
            zileConcediuNeefectuate:
                item['Zile Concediu neefectuate'] ?? "NotFound",
            zileConcediuEfectuate:
                item['Zile Concediu efectuate'] ?? "NotFound",
            concediiNeefectuatePanaLa20181231:
                item['Concedii neefectuate pana la 2018-12-31'] ?? "NotFound",
            concediiNeefectuate20191231:
                item['Concedii nefectuate 2019-12-31'] ?? "NotFound",
            concediiNeefectuate20201231:
                item['Concedii nefectuate 2020-12-31'] ?? "NotFound",
            concediiNeefectuate20211231:
                item['Concedii nefectuate 2021-12-31'] ?? "NotFound",
            concediiNeefectuate20221231:
                item['Concedii nefectuate 2022-12-31'] ?? "NotFound",
            concediiNeefectuate20231231:
                item['Concedii nefectuate 2023-12-31'] ?? "NotFound",
            concediiNeefectuate20241231:
                item['Concedii nefectuate 2024-12-31'] ?? "NotFound",
            totalNeefectuate: item['Total Neefectuate'] ?? "NotFound",
            fisierCIM: item['Fisier CIM'] ?? 'NOTFOUND',
            tipPlata: item['Tip Plata'] ?? 'NOTFOUND',
            descriereJob: item['Descriere Job'] ?? 'NOTFOUND',
            responsabilitati: item['Responsabilitati'] ?? 'NOTFOUND',
            beneficii: item['Beneficii'] ?? 'NOTFOUND',
            cnp: item['CNP'] ?? 'NOTFOUND',
            zileConcediuInUrma: item['Zile concediu in urma'] ?? "NotFound",
            inputNeefectuate2024: item['Input Neefectuate 2024'] ?? "NotFound",
          );
          angajatiListHelper.add(angajat);
        }

        _angajatiList = angajatiListHelper;
        _angajatiDataSource = AngajatiDataSource(angajatiList: _angajatiList);
        notifyListeners();
      } else {
        print('Failed to load angajati: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching angajati from AppSheet API: $e');
    }
  }

  Future<void> refreshData() async {
    _angajatiList = [];
    await fetchAngajatiFromAppSheet();
  }
}
