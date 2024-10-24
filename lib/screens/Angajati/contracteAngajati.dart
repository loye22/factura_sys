import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:factura_sys/models/Angajati_Model.dart';
import 'package:factura_sys/models/entitati_Model.dart';
import 'package:factura_sys/provider/angajatiProvider.dart';
import 'package:factura_sys/provider/entitatiProvider.dart';
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

class contracteAngajati extends StatefulWidget {
  const contracteAngajati({super.key});

  @override
  State<contracteAngajati> createState() => _contracteAngajatiState();
}

class _contracteAngajatiState extends State<contracteAngajati> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
     final angajatiProvider = Provider.of<AngajatiProvider>(context);

    return !angajatiProvider.hasData
        ? staticVar.loading()
        :
        Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Angajat',
        backgroundColor: const Color(0xFF3776B6),
        onPressed: () async {
          showAngajatiDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SfDataGrid(
        controller: _dataGridController,
        allowSorting: true,
        allowFiltering: true,
        columnWidthMode: ColumnWidthMode.auto,
        source: angajatiProvider.angajatiDataSource,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'ID Angajat',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Angajat'),
            ),
          ),
          GridColumn(
            columnName: 'CUI Angajator',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Angajator'),
            ),
          ),
          GridColumn(
            columnName: 'Nume Angajator',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Angajator'),
            ),
          ),
          GridColumn(
            columnName: 'Nume Prenume',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Prenume'),
            ),
          ),
          GridColumn(
            columnName: 'Functia',
            label: Container(
              alignment: Alignment.center,
              child: Text('Functia'),
            ),
          ),
          GridColumn(
            columnName: 'Nr Contract',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nr Contract'),
            ),
          ),
          GridColumn(
            columnName: 'Data Contract',
            label: Container(
              alignment: Alignment.center,
              child: Text('Data Contract'),
            ),
          ),
          GridColumn(
            columnName: 'Ore',
            label: Container(
              alignment: Alignment.center,
              child: Text('Ore'),
            ),
          ),
          GridColumn(
            columnName: 'Salariu Brut',
            label: Container(
              alignment: Alignment.center,
              child: Text('Salariu Brut'),
            ),
          ),
          GridColumn(
            columnName: 'Zile Concediu Neefectuate',
            label: Container(
              alignment: Alignment.center,
              child: Text('Zile Concediu Neefectuate'),
            ),
          ),
          GridColumn(
            columnName: 'Zile Concediu Efectuate',
            label: Container(
              alignment: Alignment.center,
              child: Text('Zile Concediu Efectuate'),
            ),
          ),
          GridColumn(
            columnName: 'Concedii neefectuate pana la 2018-12-31',
            label: Container(
              alignment: Alignment.center,
              child: Text('Concedii neefectuate pana la 2018-12-31'),
            ),
          ),
          GridColumn(
            columnName: 'Concedii neefectuate 2019-12-31',
            label: Container(
              alignment: Alignment.center,
              child: Text('Concedii neefectuate 2019-12-31'),
            ),
          ),
          GridColumn(
            columnName: 'Concedii neefectuate 2020-12-31',
            label: Container(
              alignment: Alignment.center,
              child: Text('Concedii neefectuate 2020-12-31'),
            ),
          ),
          GridColumn(
            columnName: 'Concedii neefectuate 2021-12-31',
            label: Container(
              alignment: Alignment.center,
              child: Text('Concedii neefectuate 2021-12-31'),
            ),
          ),
          GridColumn(
            columnName: 'Concedii neefectuate 2022-12-31',
            label: Container(
              alignment: Alignment.center,
              child: Text('Concedii neefectuate 2022-12-31'),
            ),
          ),
          GridColumn(
            columnName: 'Concedii neefectuate 2023-12-31',
            label: Container(
              alignment: Alignment.center,
              child: Text('Concedii neefectuate 2023-12-31'),
            ),
          ),
          GridColumn(
            columnName: 'Concedii neefectuate 2024-12-31',
            label: Container(
              alignment: Alignment.center,
              child: Text('Concedii neefectuate 2024-12-31'),
            ),
          ),
          GridColumn(
            columnName: 'Total Neefectuate',
            label: Container(
              alignment: Alignment.center,
              child: Text('Total Neefectuate'),
            ),
          ),
          GridColumn(
            columnName: 'Fisier CIM',
            label: Container(
              alignment: Alignment.center,
              child: Text('Fisier CIM'),
            ),
          ),
          GridColumn(
            columnName: 'Tip Plata',
            label: Container(
              alignment: Alignment.center,
              child: Text('Tip Plata'),
            ),
          ),
          GridColumn(
            columnName: 'Descriere Job',
            label: Container(
              alignment: Alignment.center,
              child: Text('Descriere Job'),
            ),
          ),
          GridColumn(
            columnName: 'Responsabilitati',
            label: Container(
              alignment: Alignment.center,
              child: Text('Responsabilitati'),
            ),
          ),
          GridColumn(
            columnName: 'Beneficii',
            label: Container(
              alignment: Alignment.center,
              child: Text('Beneficii'),
            ),
          ),
          GridColumn(
            columnName: 'CNP',
            label: Container(
              alignment: Alignment.center,
              child: Text('CNP'),
            ),
          ),
          GridColumn(
            columnName: 'Zile concediu in urma',
            label: Container(
              alignment: Alignment.center,
              child: Text('Zile concediu in urma'),
            ),
          ),
          GridColumn(
            columnName: 'Input Neefectuate 2024',
            label: Container(
              alignment: Alignment.center,
              child: Text('Input Neefectuate 2024'),
            ),
          ),
        ],
      ),
    );
  }
}

class AngajatiDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Adaugă Angajat"),
      content: Text("Ask cosmen about it!!"), //AngajatiForm(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Anulează"),
        ),
      ],
    );
  }
}

class AngajatiForm extends StatefulWidget {
  @override
  State<AngajatiForm> createState() => _AngajatiFormState();
}

class _AngajatiFormState extends State<AngajatiForm> {
  final _formKey = GlobalKey<FormState>();
  final _idAngajatController = TextEditingController();
  final _cuiAngajatorController = TextEditingController();
  final _numeAngajatorController = TextEditingController();
  final _numePrenumeController = TextEditingController();
  bool isLoading = false;
  String? selectedValueFromDropDown;

  Future<void> _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() => isLoading = true);

        final String idAngajat = _idAngajatController.text.trim();
        final String cuiAngajator = _cuiAngajatorController.text.trim();
        final String numeAngajator = _numeAngajatorController.text.trim();
        final String numePrenume = _numePrenumeController.text.trim();
        User? user = FirebaseAuth.instance.currentUser;

        // Prepare the data to be added
        Map<String, dynamic> data = {
          'idAngajat': idAngajat,
          'cuiAngajator': cuiAngajator,
          'numeAngajator': numeAngajator,
          'numePrenume': numePrenume,
          'timestamp': DateTime.now(),
          'userEmail': user!.email,
        };

        // Access the provider and call the addAngajat method
        // await Provider.of<AngajatiProvider>(context, listen: false)
        //     .addAngajat(context: context, data: data);

        print("Angajat adăugat: $idAngajat");
        Navigator.of(context).pop(); // Close the dialog after submission
      } else {
        setState(() => isLoading = false);
        print("Invalid input");
      }
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Ceva nu a mers bine: $e",
        ),
      );
      print("Error: $e");
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelStyle: const TextStyle(color: Color(0xFF444444)),
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
    );
  }

  @override
  void dispose() {
    _idAngajatController.dispose();
    _cuiAngajatorController.dispose();
    _numeAngajatorController.dispose();
    _numePrenumeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _idAngajatController,
            decoration: _buildInputDecoration('ID Angajat', Icons.person),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Introduceți ID Angajat';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _cuiAngajatorController,
            decoration: _buildInputDecoration('CUI Angajator', Icons.business),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Introduceți CUI Angajator';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _numeAngajatorController,
            decoration:
                _buildInputDecoration('Nume Angajator', Icons.text_fields),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Introduceți Nume Angajator';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _numePrenumeController,
            decoration: _buildInputDecoration('Nume Prenume', Icons.person),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Introduceți Nume Prenume';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          isLoading
              ? const CircularProgressIndicator()
              : CustomButtons(
                  label: 'Adaugă Angajat',
                  onPressed: _submitForm,
                ),
        ],
      ),
    );
  }
}

// Function to show the Angajati dialog
void showAngajatiDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AngajatiDialog();
    },
  );
}
