
import 'package:factura_sys/provider/TranzactiiProvider.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/staticVar.dart';

class cautaTranzactii extends StatefulWidget {
  const cautaTranzactii({super.key});

  @override
  State<cautaTranzactii> createState() => _cautaTranzactiiState();
}

class _cautaTranzactiiState extends State<cautaTranzactii> {
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tranzactiiProviderVar = Provider.of<TranzactiiProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă tranzacție',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          // showTranzactiiDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: !tranzactiiProviderVar.hasData
          ? staticVar.loading()
          : SfDataGrid(
        controller: _dataGridController,
        allowSorting: true,
        allowFiltering: true,
        columnWidthMode: ColumnWidthMode.auto,
        source: tranzactiiProviderVar.tranzactiiDataSource,
        columns: <GridColumn> [
          GridColumn(
            columnName: 'idLink',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Link'),
            ),
          ),
          GridColumn(
            columnName: 'dataTranzactie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Data Tranzacție'),
            ),
          ),
          GridColumn(
            columnName: 'idTranzactie',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Tranzacție'),
            ),
          ),
          GridColumn(
            columnName: 'metodaTranzactie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Metodă Tranzacție'),
            ),
          ),
          GridColumn(
            columnName: 'tipTranzactie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Tip Tranzacție'),
            ),
          ),
          GridColumn(
            columnName: 'ibanTitular',
            label: Container(
              alignment: Alignment.center,
              child: Text('IBAN Titular'),
            ),
          ),
          GridColumn(
            columnName: 'numeTitular',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Titular'),
            ),
          ),
          GridColumn(
            columnName: 'bancaTitular',
            label: Container(
              alignment: Alignment.center,
              child: Text('Bancă Titular'),
            ),
          ),
          GridColumn(
            columnName: 'cuiTitular',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Titular'),
            ),
          ),
          GridColumn(
            columnName: 'ibanPlatitor',
            label: Container(
              alignment: Alignment.center,
              child: Text('IBAN Plătitor'),
            ),
          ),
          GridColumn(
            columnName: 'numePlatitor',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Plătitor'),
            ),
          ),
          GridColumn(
            columnName: 'bancaPlatitor',
            label: Container(
              alignment: Alignment.center,
              child: Text('Bancă Plătitor'),
            ),
          ),
          GridColumn(
            columnName: 'cuiPlatitor',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Plătitor'),
            ),
          ),
          GridColumn(
            columnName: 'ibanDestinatar',
            label: Container(
              alignment: Alignment.center,
              child: Text('IBAN Destinatar'),
            ),
          ),
          GridColumn(
            columnName: 'numeDestinatar',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Destinatar'),
            ),
          ),
          GridColumn(
            columnName: 'bancaDestinatar',
            label: Container(
              alignment: Alignment.center,
              child: Text('Bancă Destinatar'),
            ),
          ),
          GridColumn(
            columnName: 'cuiDestinatar',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Destinatar'),
            ),
          ),
          GridColumn(
            columnName: 'motivTranzactie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Motiv Tranzacție'),
            ),
          ),
          GridColumn(
            columnName: 'descriereTranzactie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Descriere Tranzacție'),
            ),
          ),
          GridColumn(
            columnName: 'referinta',
            label: Container(
              alignment: Alignment.center,
              child: Text('Referință'),
            ),
          ),
          GridColumn(
            columnName: 'numarIdentificare',
            label: Container(
              alignment: Alignment.center,
              child: Text('Număr Identificare'),
            ),
          ),
          GridColumn(
            columnName: 'moneda',
            label: Container(
              alignment: Alignment.center,
              child: Text('Monedă'),
            ),
          ),
          GridColumn(
            columnName: 'sumaTranzactie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Sumă Tranzacție'),
            ),
          ),
          GridColumn(
            columnName: 'debit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Debit'),
            ),
          ),
          GridColumn(
            columnName: 'credit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Credit'),
            ),
          ),
          GridColumn(
            columnName: 'enumFacturi',
            label: Container(
              alignment: Alignment.center,
              child: Text('Enum Facturi'),
            ),
          ),
          GridColumn(
            columnName: 'soldInitial',
            label: Container(
              alignment: Alignment.center,
              child: Text('Sold Inițial'),
            ),
          ),
          GridColumn(
            columnName: 'soldFinal',
            label: Container(
              alignment: Alignment.center,
              child: Text('Sold Final'),
            ),
          ),
        ],
      ),
    );
  }
}

class TranzactiiDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Tranzacție"),
      content: TranzactiiForm(),
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

class TranzactiiForm extends StatefulWidget {
  @override
  State<TranzactiiForm> createState() => _TranzactiiFormState();
}

class _TranzactiiFormState extends State<TranzactiiForm> {
  final _formKey = GlobalKey<FormState>();
  final _sumaController = TextEditingController();
  final _tipTranzactieController = TextEditingController();
  final _comentariiController = TextEditingController();
  DateTime? _dataTranzactie;
  bool isLoading = false;

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dataTranzactie = pickedDate;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final suma = double.tryParse(_sumaController.text.trim()) ?? 0.0;
      final tipTranzactie = _tipTranzactieController.text.trim();
      final comentarii = _comentariiController.text.trim();
      User? user = FirebaseAuth.instance.currentUser;

      Map<String, dynamic> data = {
        'suma': suma,
        'tipTranzactie': tipTranzactie,
        'dataTranzactie': _dataTranzactie,
        'comentarii': comentarii,
        'timestamp': DateTime.now(),
        'userEmail': user?.email,
      };

      await Provider.of<TranzactiiProvider>(context, listen: false)
          .addTranzactie(context: context, data: data);

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
                controller: _sumaController,
                decoration: _buildInputDecoration('Sumă', Icons.money),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduceți o sumă validă';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _tipTranzactieController,
                decoration: _buildInputDecoration('Tip Tranzacție', Icons.description),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduceți tipul tranzacției';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _comentariiController,
                decoration: _buildInputDecoration('Comentarii', Icons.comment),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => _pickDate(context),
                child: Text(_dataTranzactie == null
                    ? 'Alegeți Data Tranzacției'
                    : 'Data: ${_dataTranzactie!.toLocal()}'),
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                label: 'Adaugă Tranzacție',
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to show the dialog
void showTranzactiiDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return TranzactiiDialog();
    },
  );
}
