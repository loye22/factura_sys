import 'dart:convert';
import 'package:factura_sys/models/Facturi_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

class FacturaProvider with ChangeNotifier {
  List<Factura_Model> _facturaList = []; // List to hold Factura models
  late FacturaDataSource _facturaDataSources; // Data source

  // Getter for facturaDataSource
  FacturaDataSource get facturaDataSources => _facturaDataSources;

  // Check if data has already been fetched
  bool get hasData => _facturaList.isNotEmpty;

  FacturaProvider() {
    fetchFacturaFromAppSheet();
  }

  Future<void> fetchFacturaFromAppSheet() async {
    // Skip fetching if data is already present
    if (_facturaList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI +
          'Facturi/Action'; // Adjust endpoint for Factura
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
      final response = await http.post(
          Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Factura_Model> facturaListHelper = [];

        // Parse the response and create Factura_Model objects
        for (var item in data) {
          print(item['Data Emitere']);
          Factura_Model factura = Factura_Model(
            idLink: item['ID Link'] ?? 'NOTFOUND',
            cuiFirmaGestiune: item['CUI Firma Gestiune'] ?? 'NOTFOUND',
            denumireFirmaGestiune: item['Denumire Frima Gestiune'] ??
                'NOTFOUND',
            idRelatieComerciala: item['ID Relatie Comerciala'] ?? 'NOTFOUND',
            idContract: item['ID Contract'] ?? 'NOTFOUND',
            idAnexa: item['ID Anexa'] ?? 'NOTFOUND',
            idFactura: item['ID factura'] ?? 'NOTFOUND',
            fisierFactura: item['Fisier Factura'] ?? 'NOTFOUND',
            fisiereAnexe: item['Fisiere Anexe'] ?? 'NOTFOUND',
            tipFactura: item['Tip Factura'] ?? 'NOTFOUND',
            statusFactura: item['Status Factura'] ?? 'NOTFOUND',
            planificat: item['Planificat?'] == 'Y',
            cuiFurnizor: item['CUI Furnizor'] ?? 'NOTFOUND',
            numeFurnizor: item['Nume Furnizor'] ?? 'NOTFOUND',
            ibanFurnizor: item['IBAN Furnizor'] ?? 'NOTFOUND',
            bancaFurnizor: item['Banca Furnizor'] ?? 'NOTFOUND',
            cuiBeneficiar: item['CUI Beneficiar'] ?? 'NOTFOUND',
            numeBeneficiar: item['Nume Beneficiar'] ?? 'NOTFOUND',
            ibanBeneficiar: item['IBAN Beneficiar'] ?? 'NOTFOUND',
            bancaBeneficiar: item['Banca Beneficiar'] ?? 'NOTFOUND',
            cuiPlatitor: item['CUI Platitor'] ?? 'NOTFOUND',
            numePlatitor: item['Nume Platitor'] ?? 'NOTFOUND',
            ibanPlatitor: item['IBAN Platitor'] ?? 'NOTFOUND',
            bancaPlatitor: item['Banca Platitor'] ?? 'NOTFOUND',
            serie: item['Serie'] ?? 'NOTFOUND',
            numar: item['Numar'] ?? 'NOTFOUND',
            dataEmitere: staticVar.convertStringToDate(item['Data Emitere'] ),
            dataScadenta: staticVar.convertStringToDate(item['Data Scadenta']) ,
            punctDeConsum: item['Punct de consum'] ?? 'NOTFOUND',
            descriere: item['Descriere'] ?? 'NOTFOUND',
            moneda: item['Moneda'] ?? 'NOTFOUND',
            subtotal: double.tryParse(item['Subtotal'].toString()) ?? 0.0,
            procentTaxe: double.tryParse(item['Procent Taxe'].toString()) ??
                0.0,
            valoareTaxe: double.tryParse(item['Valoare Taxe'].toString()) ??
                0.0,
            valoareTotala: double.tryParse(item['Valoare Totala'].toString()) ??
                0.0,
            retineriTaxe: item['Retineri taxe?'] == 'Y',
            totalDePlata: double.tryParse(item['Total de Plata'].toString()) ??
                0.0,
            metodaDePlata: item['Metoda de Plata'] ?? 'NOTFOUND',
            procentDeducereTVA: double.tryParse(
                item['Procent Deducere TVA'].toString()) ?? 0.0,
            valoareDeducereTVA: double.tryParse(
                item['Valoare Deducere TVA'].toString()) ?? 0.0,
            tipSold: item['Tip Sold'] ?? 'NOTFOUND',
            sold: double.tryParse(item['Sold'].toString()) ?? 0.0,
            credit: double.tryParse(item['Credit'].toString()) ?? 0.0,
            debit: double.tryParse(item['Debit'].toString()) ?? 0.0,
            enumIdArticoleFacturi: item['Enum ID Articole Facturi'] ??
                'NOTFOUND',
            subtotalArticole: double.tryParse(
                item['Subtotal Articole'].toString()) ?? 0.0,
            valoareTotalaArticole: double.tryParse(
                item['Valoare Totala Articole'].toString()) ?? 0.0,
            totalValoareTaxeArticole: double.tryParse(
                item['Total Valoare Taxe Articole'].toString()) ?? 0.0,
            areArticoleInSistem: item['Are articole in sistem?'] == 'Y',
            valoareArticoleSistemEqualsFactura: item['Valoare Articole Sistem = Factura ?'] ==
                'Y',
            facturaAChitata: item['Factura a fost achitata?'] == 'Y',
            soldRamasNeachitat: double.tryParse(
                item['Sold Ramas Neachitat'].toString()) ?? 0.0,
            statusPlata: item['Status Plata'] ?? 'NOTFOUND',
            enumTranzactii: item['Enum Tranzactii'] ?? 'NOTFOUND',
            fisierNIR: item['Fisier NIR'] ?? 'NOTFOUND',
            detaliiExtra: item['Detalii Extra?'] ?? 'NOTFOUND',
            codClient: item['Cod Client'] ?? 'NOTFOUND',
            numarSAP: item['Numar SAP'] ?? 'NOTFOUND',
            codPlata: item['Cod Plata'] ?? 'NOTFOUND',
            codDeBare: item['Cod de Bare'] ?? 'NOTFOUND',
            numarRata: item['Numar Rata'] ?? 'NOTFOUND',
            categorieTag: item['Categorie Tag'] ?? 'NOTFOUND',
            subcategorieTag: item['Subcategorie Tag'] ?? 'NOTFOUND',
            brand: item['Brand'] ?? 'NOTFOUND',
            scop: item['Scop'] ?? 'NOTFOUND',
            tagIndividual: item['Tag Individual'] ?? 'NOTFOUND',
            cuiBeneficiarLabel: item['CUI Beneficiar Label'] ?? 'NOTFOUND',
            numeBeneficiarLabel: item['Nume Beneficiar Label'] ?? 'NOTFOUND',


          );
          facturaListHelper.add(factura);
        }

        _facturaList = facturaListHelper;
        _facturaDataSources = FacturaDataSource(facturi: _facturaList);
        print(_facturaList.length);
        notifyListeners(); // Notify UI about changes
      } else {
        print('Failed to load Facturas: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching Facturas from AppSheet API: $e');
      // Handle error
    }
  }



  // Method to refresh data
  Future<void> refreshData() async {
    _facturaList = []; // Clear cache
    await fetchFacturaFromAppSheet(); // Fetch fresh data
  }

  // Method to add a new Factura using AppSheet API
  Future<void> addFactura({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPI +
        'Factura/Action'; // Adjust endpoint for Factura
    final headers = {
      'ApplicationAccessKey': 'YOUR_ACCESS_KEY',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "ClientName": data['clientName'],
          "Amount": data['amount']?.toDouble() ?? 0.0,
          "Date": formatDate(data['date'] ?? DateTime.now()),
          // Add other fields as necessary
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
        refreshData();
        notifyListeners();
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Factura adăugată cu succes!",
          ),
        );
      } else {
        print(
            'Failed to add factura: ${response.statusCode} - ${response.body}');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Eroare la adăugarea facturii. Vă rugăm să încercați din nou.",
          ),
        );
      }
    } catch (e) {
      print('Error adding factura: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Eroare la adăugarea facturii. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }

  // Convert DateTime to ISO 8601 format strings
  String? formatDate(DateTime? date) {
    return date?.toIso8601String();
  }
}
