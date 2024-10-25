import 'dart:convert';
import 'package:factura_sys/models/tranzactii_Model.dart'; // Import the new model
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TranzactiiProvider with ChangeNotifier {
  List<TranzactiiModel> _tranzactiiList = [];
  late TranzactiiDataSource _tranzactiiDataSource;

  TranzactiiDataSource get tranzactiiDataSource => _tranzactiiDataSource;

  bool get hasData => _tranzactiiList.isNotEmpty;

  TranzactiiProvider() {
    fetchTranzactiiFromAppSheet();
  }

  Future<void> fetchTranzactiiFromAppSheet() async {
    if (_tranzactiiList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Tranzactii/Action';
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

        List<TranzactiiModel> tranzactiiListHelper = [];

        for (var item in data) {

          TranzactiiModel tranzactie = TranzactiiModel(
            idLink: item['ID Link'] ?? 'NOTFOUND',
            dataTranzactie:parseDate(item['Data Tranzactie'] ?? '10/10/1800'), // You may want to parse this as needed
            idTranzactie: item['ID Tranzactie'] ?? 'NOTFOUND',
            metodaTranzactie: item['Metoda Tranzactie'] ?? 'NOTFOUND',
            tipTranzactie: item['Tip Tranzactie'] ?? 'NOTFOUND',
            ibanTitular: item['IBAN Titular'] ?? 'NOTFOUND',
            numeTitular: item['Nume Titular'] ?? 'NOTFOUND',
            bancaTitular: item['Banca Titular'] ?? 'NOTFOUND',
            cuiTitular: item['CUI Titular'] ?? 'NOTFOUND',
            ibanPlatitor: item['IBAN Platitor'] ?? 'NOTFOUND',
            numePlatitor: item['Nume Platitor'] ?? 'NOTFOUND',
            bancaPlatitor: item['Banca Platitor'] ?? 'NOTFOUND',
            cuiPlatitor: item['CUI Platitor'] ?? 'NOTFOUND',
            ibanDestinatar: item['IBAN Destinatar'] ?? 'NOTFOUND',
            numeDestinatar: item['Nume Destinatar'] ?? 'NOTFOUND',
            bancaDestinatar: item['Banca Destinatar'] ?? 'NOTFOUND',
            cuiDestinatar: item['CUI Destinatar'] ?? 'NOTFOUND',
            motivTranzactie: item['Motiv Tranzactie'] ?? 'NOTFOUND',
            descriereTranzactie: item['Descriere Tranzactie'] ?? 'NOTFOUND',
            referinta: item['Referinta'] ?? 'NOTFOUND',
            numarIdentificare: item['Numar identificare'] ?? 'NOTFOUND',
            moneda: item['Moneda'] ?? 'NOTFOUND',
            sumaTranzactie: double.tryParse(item['Suma Tranzactie']?.toString() ?? '0') ?? 0.0,
            debit: double.tryParse(item['Debit']?.toString() ?? '0') ?? 0.0,
            credit: double.tryParse(item['Credit']?.toString() ?? '0') ?? 0.0,
            enumFacturi: item['Enum Facturi'] ?? 'NOTFOUND',
            soldInitial: double.tryParse(item['Sold Initial']?.toString() ?? '0') ?? 0.0,
            soldFinal: double.tryParse(item['Sold Final']?.toString() ?? '0') ?? 0.0,
          )

          ;
          tranzactiiListHelper.add(tranzactie);
        }

        _tranzactiiList = tranzactiiListHelper;
        _tranzactiiDataSource = TranzactiiDataSource(tranzactii: _tranzactiiList);
        notifyListeners();
      } else {
        print('Failed to load transactions: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching transactions from AppSheet API: $e');
    }
  }

  Future<void> refreshData() async {
    _tranzactiiList = [];
    await fetchTranzactiiFromAppSheet();
  }

  Future<void> addTranzactie({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    return ;
    final String url = staticVar.urlAPI + 'Tranzactii/Action';
    final headers = {
      'ApplicationAccessKey': 'YOUR_ACCESS_KEY',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "idLink": data['idLink'],
          "dataTranzactie": DateTime(1800),//formatDate(data['dataTranzactie']),
          "idTranzactie": data['idTranzactie'],
          "metodaTranzactie": data['metodaTranzactie'],
          "tipTranzactie": data['tipTranzactie'],
          "ibanTitular": data['ibanTitular'],
          "numeTitular": data['numeTitular'],
          "bancaTitular": data['bancaTitular'],
          "cuiTitular": data['cuiTitular'],
          "ibanPlatitor": data['ibanPlatitor'],
          "numePlatitor": data['numePlatitor'],
          "bancaPlatitor": data['bancaPlatitor'],
          "cuiPlatitor": data['cuiPlatitor'],
          "ibanDestinatar": data['ibanDestinatar'],
          "numeDestinatar": data['numeDestinatar'],
          "bancaDestinatar": data['bancaDestinatar'],
          "cuiDestinatar": data['cuiDestinatar'],
          "motivTranzactie": data['motivTranzactie'],
          "descriereTranzactie": data['descriereTranzactie'],
          "referinta": data['referinta'],
          "numarIdentificare": data['numarIdentificare'],
          "moneda": data['moneda'],
          "sumaTranzactie": data['sumaTranzactie']?.toDouble() ?? 0.0,
          "debit": data['debit']?.toDouble() ?? 0.0,
          "credit": data['credit']?.toDouble() ?? 0.0,
          "enumFacturi": data['enumFacturi'],
          "soldInitial": data['soldInitial']?.toDouble() ?? 0.0,
          "soldFinal": data['soldFinal']?.toDouble() ?? 0.0,
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

        TranzactiiModel newTranzactie = TranzactiiModel(
          idLink: data['idLink'] ?? 'generated-id',
          dataTranzactie: DateTime.now(),
          idTranzactie: data['idTranzactie'],
          metodaTranzactie: data['metodaTranzactie'],
          tipTranzactie: data['tipTranzactie'],
          ibanTitular: data['ibanTitular'],
          numeTitular: data['numeTitular'],
          bancaTitular: data['bancaTitular'],
          cuiTitular: data['cuiTitular'],
          ibanPlatitor: data['ibanPlatitor'],
          numePlatitor: data['numePlatitor'],
          bancaPlatitor: data['bancaPlatitor'],
          cuiPlatitor: data['cuiPlatitor'],
          ibanDestinatar: data['ibanDestinatar'],
          numeDestinatar: data['numeDestinatar'],
          bancaDestinatar: data['bancaDestinatar'],
          cuiDestinatar: data['cuiDestinatar'],
          motivTranzactie: data['motivTranzactie'],
          descriereTranzactie: data['descriereTranzactie'],
          referinta: data['referinta'],
          numarIdentificare: data['numarIdentificare'],
          moneda: data['moneda'],
          sumaTranzactie: data['sumaTranzactie']?.toDouble() ?? 0.0,
          debit: data['debit']?.toDouble() ?? 0.0,
          credit: data['credit']?.toDouble() ?? 0.0,
          enumFacturi: data['enumFacturi'],
          soldInitial: data['soldInitial']?.toDouble() ?? 0.0,
          soldFinal: data['soldFinal']?.toDouble() ?? 0.0,
        );

        _tranzactiiList.add(newTranzactie);
        _tranzactiiDataSource = TranzactiiDataSource(tranzactii: _tranzactiiList);
        notifyListeners();

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Tranzactie adaugata cu succes!",
          ),
        );
      } else {
        print('Failed to add tranzactie: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error adding tranzactie: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adaugarea tranzactiei.",
        ),
      );
    }
  }

  DateTime parseDate(String dateStr) {
    try {
      // Replace slashes and dashes with a space
      dateStr = dateStr.replaceAll('/', ' ').replaceAll('-', ' ');

      // Split the string into parts
      List<String> parts = dateStr.split(' ');

      // Check if we have the right number of parts (month, day, year)
      if (parts.length == 3) {
        // Create a DateTime object using the parts
        return DateTime(int.parse(parts[2]), int.parse(parts[0]), int.parse(parts[1]));
      } else {
        throw FormatException("Invalid date format");
      }
    } catch (e) {
      // Handle the parsing error
      print("Error parsing date: $e");
      return DateTime(1800); // Or any default value you prefer
    }
  }

}
