import 'dart:convert';
import 'package:factura_sys/models/relatii_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RelatiiProvider with ChangeNotifier {
  List<relatii_Model> _relatiiList = []; // Make this nullable
  late RelatiiDataSource _relatiiDataSource;

  // Getter for relatiiDataSource
  RelatiiDataSource get relatiiDataSource => _relatiiDataSource;

  // Check if data has already been fetched
  bool get hasData => _relatiiList.isNotEmpty;

  RelatiiProvider() {
    fetchRelatiiFromAppSheet();
  }

  Future<void> fetchRelatiiFromAppSheet() async {
    // Skip fetching if data is already present
    if (_relatiiList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'Relatii comerciale/Action';
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

        List<relatii_Model> relatiiListHelper = [];

        // Assuming that the response is a list of rows
        for (var item in data) {
    
          relatii_Model relatie = relatii_Model(
            idRelatieComerciala: item['ID Relatie Comerciala'] ?? 'NOTFOUND',
            cuiFirmaGestiune: item['CUI Firma Gestiune'] ?? 'NOTFOUND',
            denumireFirma: item['Denumire Firma'] ?? 'NOTFOUND',
            cuiPartener: item['CUI Partener'] ?? 'NOTFOUND',
            denumirePartener: item['Denumire Partener'] ?? 'NOTFOUND',
            idContract: item['ID Contract'] ?? 'NOTFOUND',
            denumireContract: item['Denumire Contract'] ?? 'NOTFOUND',
            descriereContract: item['Descriere Contract'] ?? 'NOTFOUND',
            dataIncepereContract:parseDate(item['Data Incepere Contract']),
            dataIncetareContract:parseDate(item['Data Incetare Contract']) ,
            clientFurnizor: item['Client / Furnizor'] ?? 'NOTFOUND',
            categorie: item['Categorie'] ?? 'NOTFOUND',
            subcategorie: item['Subcategorie'] ?? 'NOTFOUND',
            totalCredit: double.tryParse(item['Total Credit']?.toString() ?? '0') ?? 0.0,
            tranzactiiCredit: double.tryParse(item['Tranzactii Credit']?.toString() ?? '0') ?? 0.0,
            medieTranzactiiCredit: double.tryParse(item['Medie Tranzactii Credit']?.toString() ?? '0') ?? 0.0,
            totalDebit: double.tryParse(item['Total Debit']?.toString() ?? '0') ?? 0.0,
            tranzactiiDebit: double.tryParse(item['Tranzactii Debit']?.toString() ?? '0') ?? 0.0,
            medieTranzactiiDebit: double.tryParse(item['Medie Tranzactii Debit']?.toString() ?? '0') ?? 0.0,
            balanta: double.tryParse(item['Balanta']?.toString() ?? '0') ?? 0.0,
            labelRelatieComerciala: item['Label Relatie Comerciala'] ?? 'NOTFOUND',
          );
          relatiiListHelper.add(relatie);
        }

        _relatiiList = relatiiListHelper;
        _relatiiDataSource = RelatiiDataSource(relatii: _relatiiList);
        notifyListeners();  // Notify UI about changes
      } else {
        print('Failed to load relatii: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching relatii from AppSheet API: $e');
      // Handle error (e.g., show a SnackBar, etc.)
    }
  }

  // Refresh method if you want to force re-fetch
  Future<void> refreshData() async {
    _relatiiList = []; // Clear cache
    await fetchRelatiiFromAppSheet(); // Fetch fresh data
  }


  Future<void> addRelatie({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI + 'Relatii comerciale/Action';
    final headers = {
      'ApplicationAccessKey': 'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "CUI Firma Gestiune": data['cuiFirmaGestiune'],
          "ID Relatie Comerciala": data['idRelatieComerciala'],
          "CUI Partener": data['cuiPartener'],
          "Subcategorie": data['subcategorie'],
          "Categorie": data['categorie'],
          "Client / Furnizor": data['clientFurnizor'],
          "ID Contract": data['idContract'],
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
        // Parse the response if needed
        final responseData = jsonDecode(response.body);
        print('AppSheet response: $responseData');

        refreshData();
        notifyListeners();
        // Show success message
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Relație adăugată cu succes!",
          ),
        );
      } else {
        // Handle API error response
        print('Failed to add entity: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea relației. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding entity: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea relației. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }


  DateTime? parseDate(String? dateString) {
    try {
      if(dateString == null )
        return null ;
      // Try to parse the date string
      final DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(dateString);
      return parsedDate; // Return the parsed DateTime object
    } catch (e) {
      // If parsing fails, return null
      return null;
    }
  }

}
