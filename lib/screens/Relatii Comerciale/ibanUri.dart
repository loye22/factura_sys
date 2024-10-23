import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factura_sys/models/iban_Model.dart';
import 'package:factura_sys/provider/ibanProvider.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/staticVar.dart';
import 'package:factura_sys/provider/ibanProvider.dart';

class ibanUri extends StatefulWidget {
  const ibanUri({super.key});

  @override
  State<ibanUri> createState() => _ibanUriState();
}

class _ibanUriState extends State<ibanUri> {
  final DataGridController _dataGridController = DataGridController();

  // late ibanDataSource ibanDataSources;
  // List<iban_Model> ibanListTodisplay = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ibanFromFirrbase();
    //
    ///ibanDataSources = ibanDataSource(ibans: ibanListTodisplay);
  }

  @override
  Widget build(BuildContext context) {
    final ibanProviderVar = Provider.of<ibanProvider>(context);

    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adaugă entitate',
          backgroundColor: Color(0xFF3776B6),
          onPressed: () async {
            ///await  uploadDataToFirebaseFromJSON("louie@aurorafoods.ro");
            showIBANDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: !ibanProviderVar.hasData
            ? staticVar.loading()
            : SfDataGrid(
                controller: _dataGridController,
                // showCheckboxColumn: true,
                // selectionMode: SelectionMode.multiple,
                allowSorting: true,
                allowFiltering: true,
                columnWidthMode: ColumnWidthMode.auto,

                // columnWidthMode: ColumnWidthMode.,
                // Disable auto-resizing
                source: ibanProviderVar.ibanDataSources,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'iban',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('IBAN'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'banca',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('Banca'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'cuiTitular',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('cuiTitular'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'denumireTitular',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('denumireTitular'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'moneda',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('moneda'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'contPropriu',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('contPropriu'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'soldInitial',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('soldInitial'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'soldCurent',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('soldCurent'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'dataPrimaTranzactieExtras',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('dataPrimaTranzactieExtras'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'dataUltimaTranzactie',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('dataUltimaTranzactie'),
                    ),


                  )
                ],
              ));

    //Container( child: Center(child: Text("entitati page ")),);
  }

  Future<void> uploadDataToFirebaseFromJSON(String userEmail) async {
    int i = 0;
    // Load JSON data from file (assuming your JSON is in assets folder)
    final String response = await rootBundle.loadString('ee.json');
    final List<dynamic> data = json.decode(response); // Decode the JSON file

    // Get Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (var item in data) {
      i++;
      // Adapt each record to the Firebase structure
      Map<String, dynamic> adaptedRecord = {
        'iban': item['IBAN'],
        'banca': item['Banca'],
        'cuiTitular': item["CUI Titular"],
        'denumireTitular': item["Denumire Titular"],
        'moneda': item["Moneda"],
        'contPropriu': item["Cont Propriu"].toUpperCase() == "TRUE",
        'soldInitial': 0.0,
        // Convert to double
        'soldCurent': 0.0,
        // Convert to double
        'userEmail': userEmail,
        'timestamp': DateTime.now(),
        // Assuming timestamp is stored as Timestamp in Firestore
        'dataPrimaTranzactieExtras': null,
        'dataUltimaTranzactie': null,
      };

      // Add to Firebase (assuming you have a collection named 'entities')
      await firestore.collection('ibans').add(adaptedRecord);
    }
    print("$i record as been added ");
  }
}

class IBANDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă IBAN"),
      content: IBANForm(),
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

class IBANForm extends StatefulWidget {
  @override
  State<IBANForm> createState() => _IBANFormState();
}

class _IBANFormState extends State<IBANForm> {
  final _formKey = GlobalKey<FormState>();
  final _ibanController = TextEditingController();
  final _bancaController = TextEditingController();
  final _cuiTitularController = TextEditingController();
  final _denumireTitularController = TextEditingController();
  final _soldInitialController = TextEditingController();
  final _soldCurentController = TextEditingController();
  String _moneda = 'RON';
  bool _contPropriu = false;
  DateTime? _dataPrimaTranzactie;
  DateTime? _dataUltimaTranzactie;
  bool isLoading = false;

  Future<void> _pickDate(BuildContext context, bool isPrima) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isPrima) {
          _dataPrimaTranzactie = pickedDate;
        } else {
          _dataUltimaTranzactie = pickedDate;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      this.isLoading = true;
      setState(() {});

      final iban = _ibanController.text.trim();
      final banca = _bancaController.text.trim();
      final cuiTitular = _cuiTitularController.text.trim();
      final denumireTitular = _denumireTitularController.text.trim();
      final soldInitial = _soldInitialController.text.isNotEmpty
          ? double.tryParse(_soldInitialController.text.trim())
          : null;
      final soldCurent = _soldCurentController.text.isNotEmpty
          ? double.tryParse(_soldCurentController.text.trim())
          : null;
      User? user = FirebaseAuth.instance.currentUser;

      // Print all the data
      // print("IBAN: $iban");
      // print("Banca: $banca");
      // print("CUI Titular: $cuiTitular");
      // print("Denumire Titular: $denumireTitular");
      // print("Moneda: $_moneda");
      // print("Cont Propriu: $_contPropriu");
      // print("Data Prima Tranzactie: $_dataPrimaTranzactie");
      // print("Data Ultima Tranzactie: $_dataUltimaTranzactie");
      // print("Sold Initial: $soldInitial");
      // print("Sold Curent: $soldCurent");

      // Prepare the data to be added
      Map<String, dynamic> data = {
        'iban': iban,
        'banca': banca,
        'cuiTitular': cuiTitular,
        'denumireTitular': denumireTitular,
        'moneda': _moneda,
        'contPropriu': _contPropriu,
        'dataUltimaTranzactie': _dataUltimaTranzactie,
        'dataPrimaTranzactieExtras': _dataPrimaTranzactie,
        'soldInitial': soldInitial ?? 0.0,
        'soldCurent': soldCurent ?? 0.0,
        'timestamp': DateTime.now(),
        'userEmail': user!.email,
      };

      // Access the provider and call the addEntitate method
      await Provider.of<ibanProvider>(context, listen: false)
          .addIban(context: context, data: data);

      // Handle form submission
      Navigator.of(context).pop(); // Close the dialog after submission

      // Navigator.of(context).pop(); // Close the dialog after submission
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLength: 24,
                controller: _ibanController,
                decoration:
                    _buildInputDecoration('IBAN', Icons.account_balance),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.contains(" ")) {
                    return 'Introduceți IBAN';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _bancaController,
                decoration: _buildInputDecoration('Banca', Icons.business),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Banca';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _cuiTitularController,
                decoration: _buildInputDecoration('CUI Titular', Icons.person),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți CUI Titular';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _denumireTitularController,
                decoration: _buildInputDecoration(
                    'Denumire Titular', Icons.text_fields),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Denumirea Titularului';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _moneda,
                decoration: _buildInputDecoration('Moneda', Icons.attach_money),
                items: ['USD', 'RON', 'EURO'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _moneda = newValue!;
                  });
                },
                validator: (value) => value == null ? 'Alegeți Moneda' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _soldInitialController,
                decoration: _buildInputDecoration('Sold Inițial', Icons.money),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (!_isNumeric(value!)) {
                    return 'Introduceți o valoare numerică validă';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _soldCurentController,
                decoration: _buildInputDecoration('Sold Curent', Icons.money),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (!_isNumeric(value!)) {
                    return 'Introduceți o valoare numerică validă';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cont Propriu'),
                  Switch(
                    value: _contPropriu,
                    onChanged: (newValue) {
                      setState(() {
                        _contPropriu = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => _pickDate(context, true),
                child: Text(_dataPrimaTranzactie == null
                    ? 'Alegeți Data Prima Tranzacție'
                    : 'Data: ${_dataPrimaTranzactie!.toLocal()}'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => _pickDate(context, false),
                child: Text(_dataUltimaTranzactie == null
                    ? 'Alegeți Data Ultima Tranzacție'
                    : 'Data: ${_dataUltimaTranzactie!.toLocal()}'),
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                      label: 'Adaugă IBAN',
                      onPressed: _submitForm,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isNumeric(String value) {
    if (value.isEmpty) return true; // To allow optional fields
    return double.tryParse(value) != null;
  }
}

// Function to show the dialog
void showIBANDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return IBANDialog();
    },
  );
}
