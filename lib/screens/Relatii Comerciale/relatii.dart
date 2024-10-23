import 'dart:convert';

import 'package:factura_sys/models/staticVar.dart';
import 'package:factura_sys/provider/appSheetProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class relatii extends StatefulWidget {
  const relatii({super.key});

  @override
  State<relatii> createState() => _relatiiState();
}

class _relatiiState extends State<relatii> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<appsheetProvider>(context);

    return Container(
      child: Center(
          child: Column(
        children: [
          Text("relatii page "),
          FloatingActionButton(onPressed: () {
            provider.fetchEntitatiFromAppSheet();
          })
        ],
      )),
    );
  }

  Future<void> addIban({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url = staticVar.urlAPITest + 'Creditari/Action';
    final headers = {
      'ApplicationAccessKey':
          'V2-4AMlC-ZHIwQ-6CpAF-nQgMI-k7uAl-Q677u-jTT3Q-qkOVR',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "Action": "Add",
      "Properties": {},
      "Rows": [
        {
          "ID Creditare": 'CRDT-000001',
          "CUI Firma Gestiune": '13655452',
          "ID Creditor": '13655452',
          "Input Suma Creditata": 2000000,


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

        // Create the iban_Model object
      } else {
        // Handle API error response
        print(
            'Failed to add entity: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error adding entity: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message:
              "Eroare la adăugarea entității. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
