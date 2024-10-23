import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:factura_sys/models/relatii_model.dart'; // Updated to use RelatiiModel
import 'package:factura_sys/provider/relatiiProvider.dart'; // Ensure the provider is set up for RelatiiModel
import 'package:factura_sys/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/staticVar.dart';
import '../../widgets/CustomDropdown.dart';

class relatii extends StatefulWidget {
  const relatii({super.key});

  @override
  State<relatii> createState() => _relatiiState();
}

class _relatiiState extends State<relatii> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    final relatiiProvider = Provider.of<RelatiiProvider>(context);
    return !relatiiProvider.hasData
        ? staticVar.loading()
        : Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă relație',
        backgroundColor: Color(0xFF3776B6),
        onPressed: () async {
          showRelatiiDialog(context);
       //   showRelatiiDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SfDataGrid(
        controller: _dataGridController,
        allowSorting: true,
        allowFiltering: true,
        columnWidthMode: ColumnWidthMode.auto,
        source: relatiiProvider.hasData
            ? relatiiProvider.relatiiDataSource
            :RelatiiDataSource(relatii: []),
        columns: <GridColumn>[
          GridColumn(
            columnName: 'ID Relatie Comerciala',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Relatie Comerciala'), // Exact label as per your requirement
            ),
          ),
          GridColumn(
            columnName: 'CUI Firma Gestiune',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Firma Gestiune'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Denumire Firma',
            label: Container(
              alignment: Alignment.center,
              child: Text('Denumire Firma'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'CUI Partener',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Partener'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Denumire Partener',
            label: Container(
              alignment: Alignment.center,
              child: Text('Denumire Partener'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'ID Contract',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Contract'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Denumire Contract',
            label: Container(
              alignment: Alignment.center,
              child: Text('Denumire Contract'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Descriere Contract',
            label: Container(
              alignment: Alignment.center,
              child: Text('Descriere Contract'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Data Incepere Contract',
            label: Container(
              alignment: Alignment.center,
              child: Text('Data Incepere Contract'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Data Incetare Contract',
            label: Container(
              alignment: Alignment.center,
              child: Text('Data Incetare Contract'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Client / Furnizor',
            label: Container(
              alignment: Alignment.center,
              child: Text('Client / Furnizor'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Categorie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Categorie'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Subcategorie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Subcategorie'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Total Credit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Total Credit'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Tranzactii Credit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Tranzactii Credit'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Medie Tranzactii Credit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Medie Tranzactii Credit'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Total Debit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Total Debit'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Tranzactii Debit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Tranzactii Debit'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Medie Tranzactii Debit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Medie Tranzactii Debit'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Balanta',
            label: Container(
              alignment: Alignment.center,
              child: Text('Balanta'), // Exact label
            ),
          ),
          GridColumn(
            columnName: 'Label Relatie Comerciala',
            label: Container(
              alignment: Alignment.center,
              child: Text('Label Relatie Comerciala'), // Exact label
            ),
          ),
        ],
      ),
    );
  }

  Future<void> uploadDataToFirebaseFromJSON(String userEmail) async {
    int i = 0;
    final String response = await rootBundle.loadString('assets/relatii.json');
    final List<dynamic> data = json.decode(response);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (var item in data) {
      Map<String, dynamic> adaptedRecord = {
        'idRelatieComerciala': item['ID Relatie Comerciala'],
        'cuiFirmaGestiune': item['CUI Firma Gestiune'],
        'denumireFirma': item['Denumire Firma'],
        'cuiPartener': item['CUI Partener'],
        'denumirePartener': item['Denumire Partener'],
        'idContract': item['ID Contract'],
        'denumireContract': item['Denumire Contract'],
        'descriereContract': item['Descriere Contract'],
        'dataIncepereContract': DateTime.parse(item['Data Incepere Contract']),
        'dataIncetareContract': item['Data Incetare Contract'] != null
            ? DateTime.parse(item['Data Incetare Contract'])
            : null,
        'clientFurnizor': item['Client / Furnizor'],
        'categorie': item['Categorie'],
        'subcategorie': item['Subcategorie'],
        'totalCredit': item['Total Credit'].toDouble(),
        'tranzactiiCredit': item['Tranzactii Credit'],
        'medieTranzactiiCredit': item['Medie Tranzactii Credit'].toDouble(),
        'totalDebit': item['Total Debit'].toDouble(),
        'tranzactiiDebit': item['Tranzactii Debit'],
        'medieTranzactiiDebit': item['Medie Tranzactii Debit'].toDouble(),
        'balanta': item['Balanta'].toDouble(),
        'labelRelatieComerciala': item['Label Relatie Comerciala'],
        'timestamp': DateTime.now(),
        'userEmail': userEmail,
      };
      i++;
      await firestore.collection('relatii').add(adaptedRecord);
    }
    print("$i records have been added.");
  }
}


class RelatiiForm extends StatefulWidget {
  @override
  State<RelatiiForm> createState() => _RelatiiFormState();
}

class _RelatiiFormState extends State<RelatiiForm> {
  final _formKey = GlobalKey<FormState>();
  final _cuiFirmaController = TextEditingController();
  final _idRelatieController = TextEditingController();
  final _cuiPartenerController = TextEditingController();
  final _subcategorieController = TextEditingController();
  final _categorieController = TextEditingController();
  final _clientFurnizorController = TextEditingController();
  final _idContractController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      this.isLoading = true;
      setState(() {});

      final cuiFirmaGestiune = _cuiFirmaController.text.trim();
      final idRelatieComerciala = _idRelatieController.text.trim();
      final cuiPartener = _cuiPartenerController.text.trim();
      final subcategorie = _subcategorieController.text.trim();
      final categorie = _categorieController.text.trim();
      final clientFurnizor = _clientFurnizorController.text.trim();
      final idContract = _idContractController.text.trim();



      // Prepare the data to be added
      Map<String, dynamic> data = {
        'cuiFirmaGestiune': cuiFirmaGestiune,
        'idRelatieComerciala': idRelatieComerciala,
        'cuiPartener': cuiPartener,
        'subcategorie': subcategorie,
        'categorie': categorie,
        'clientFurnizor': clientFurnizor,
        'idContract': idContract,

      };

      // Access the provider and call the addRelatie method
      await Provider.of<RelatiiProvider>(context, listen: false)
          .addRelatie(context: context, data: data);

      // Handle form submission
      Navigator.of(context).pop(); // Close the dialog after submission
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelStyle: TextStyle(color: Color(0xFF444444)),
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorStyle: TextStyle(color: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: staticVar.fullWidth(context) * .3,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _cuiFirmaController,
                decoration: _buildInputDecoration('CUI Firma Gestiune', Icons.business),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți CUI Firma Gestiune';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _idRelatieController,
                decoration: _buildInputDecoration('ID Relatie Comerciala', Icons.card_travel),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți ID Relatie Comerciala';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _cuiPartenerController,
                decoration: _buildInputDecoration('CUI Partener', Icons.person),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return ' Introduceți CUI Partener Relatie Comerciala';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _subcategorieController,
                decoration: _buildInputDecoration('Subcategorie', Icons.category),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _categorieController,
                decoration: _buildInputDecoration('Categorie', Icons.category),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _clientFurnizorController,
                decoration: _buildInputDecoration('Client / Furnizor', Icons.business_center),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _idContractController,
                decoration: _buildInputDecoration('ID Contract', Icons.document_scanner),
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                label: 'Adaugă Relație',
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RelatiiDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Relație"),
      content: RelatiiForm(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Anulează"),
        ),
      ],
    );
  }
}

// Function to show the dialog
void showRelatiiDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return RelatiiDialog();
    },
  );
}

