import 'package:factura_sys/models/concedii_Model.dart';
import 'package:factura_sys/provider/concediiProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/staticVar.dart';

class concedii extends StatefulWidget {
  const concedii({super.key});

  @override
  State<concedii> createState() => _concediiState();
}

class _concediiState extends State<concedii> {
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final concediiProviderVar = Provider.of<concediiProvider>(context);
    return !concediiProviderVar.hasData
        ? staticVar.loading()
        : Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              tooltip: 'Adaugă concediu',
              backgroundColor: staticVar.themeColor,
              onPressed: () async {

              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: /* !concediiProviderVar.hasData
            ? staticVar.loading()
            : */
                SfDataGrid(
              controller: _dataGridController,
              allowSorting: true,
              allowFiltering: true,
              columnWidthMode: ColumnWidthMode.auto,
              source: concediiProviderVar.concediiDataSources,
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'idConcediu',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('ID Concediu'),
                  ),
                ),
                GridColumn(
                  columnName: 'idAngajat',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('ID Angajat'),
                  ),
                ),
                GridColumn(
                  columnName: 'numeAngajat',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Nume Angajat'),
                  ),
                ),
                GridColumn(
                  columnName: 'cuiAngajator',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('CUI Angajator'),
                  ),
                ),
                GridColumn(
                  columnName: 'denumireFirma',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Denumire Firmă'),
                  ),
                ),
                GridColumn(
                  columnName: 'tip',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Tip'),
                  ),
                ),
                GridColumn(
                  columnName: 'dataDeLa',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Data De La'),
                  ),
                ),
                GridColumn(
                  columnName: 'dataPanaLa',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Data Până La'),
                  ),
                ),
                GridColumn(
                  columnName: 'numarZile',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Număr Zile'),
                  ),
                ),
                GridColumn(
                  columnName: 'aprobat',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Aprobat'),
                  ),
                ),
                GridColumn(
                  columnName: 'perioada',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Perioada'),
                  ),
                ),
              ],
            ));
  }
}

class ConcediuDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Concediu"),
      content: ConcediuForm(),
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

class ConcediuForm extends StatefulWidget {
  @override
  State<ConcediuForm> createState() => _ConcediuFormState();
}

class _ConcediuFormState extends State<ConcediuForm> {
  final _formKey = GlobalKey<FormState>();
  final _idAngajatController = TextEditingController();
  final _numeAngajatController = TextEditingController();
  final _cuiAngajatorController = TextEditingController();
  final _denumireFirmaController = TextEditingController();
  final _tipController = TextEditingController();
  final _numarZileController = TextEditingController();
  DateTime? _dataDeLa;
  DateTime? _dataPanaLa;
  bool isLoading = false;

  Future<void> _pickDate(BuildContext context, bool isDeLa) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isDeLa) {
          _dataDeLa = pickedDate;
        } else {
          _dataPanaLa = pickedDate;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      this.isLoading = true;
      setState(() {});

      final idAngajat = _idAngajatController.text.trim();
      final numeAngajat = _numeAngajatController.text.trim();
      final cuiAngajator = _cuiAngajatorController.text.trim();
      final denumireFirma = _denumireFirmaController.text.trim();
      final tip = _tipController.text.trim();
      final numarZile = _numarZileController.text.isNotEmpty
          ? int.tryParse(_numarZileController.text.trim())
          : null;
      User? user = FirebaseAuth.instance.currentUser;

      // Prepare the data to be added
      Map<String, dynamic> data = {
        'idAngajat': idAngajat,
        'numeAngajat': numeAngajat,
        'cuiAngajator': cuiAngajator,
        'denumireFirma': denumireFirma,
        'tip': tip,
        'dataDeLa': _dataDeLa,
        'dataPanaLa': _dataPanaLa,
        'numarZile': numarZile ?? 0,
        'timestamp': DateTime.now(),
        'userEmail': user!.email,
      };

      // Access the provider and call the addConcediu method
      // await Provider.of<concediiProvider>(context, listen: false)
      //     .addConcediu(context: context, data: data);

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
                controller: _idAngajatController,
                decoration: _buildInputDecoration('ID Angajat', Icons.person),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți ID Angajat';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _numeAngajatController,
                decoration:
                    _buildInputDecoration('Nume Angajat', Icons.text_fields),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Numele Angajatului';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _cuiAngajatorController,
                decoration:
                    _buildInputDecoration('CUI Angajator', Icons.business),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți CUI Angajator';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _denumireFirmaController,
                decoration:
                    _buildInputDecoration('Denumire Firmă', Icons.business),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Denumirea Firmei';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _tipController,
                decoration: _buildInputDecoration('Tip', Icons.description),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Tipul de Concediu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _numarZileController,
                decoration:
                    _buildInputDecoration('Număr Zile', Icons.calendar_today),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Numărul de Zile';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickDate(context, true),
                    child: Text(_dataDeLa == null
                        ? 'Selectați Data De La'
                        : 'Data De La: ${_dataDeLa!.toLocal()}'.split(' ')[0]),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickDate(context, false),
                    child: Text(_dataPanaLa == null
                        ? 'Selectați Data Până La'
                        : 'Data Până La: ${_dataPanaLa!.toLocal()}'
                            .split(' ')[0]),
                  ),
                ],
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text("Salvați"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
