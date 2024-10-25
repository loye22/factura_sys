import 'package:factura_sys/provider/firmGestiuneProvider.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/staticVar.dart';

class firmeGestiune extends StatefulWidget {
  const firmeGestiune({super.key});

  @override
  State<firmeGestiune> createState() => _firmeGestiuneState();
}

class _firmeGestiuneState extends State<firmeGestiune> {
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firmeGestiuneProvider = Provider.of<firmGestiuneProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Firmă',
        backgroundColor: Color(0xFF3776B6),
        onPressed: () async {
          // showFirmeGestiuneDialog(context);

        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: !firmeGestiuneProvider.hasData
          ? staticVar.loading()
          : SfDataGrid(
              controller: _dataGridController,
              allowSorting: true,
              allowFiltering: true,
              columnWidthMode: ColumnWidthMode.fill,
              source: firmeGestiuneProvider.firmDataSource,
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'cuiFirmaGestiune',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('CUI Firma Gestiune'),
                  ),
                ),
                GridColumn(
                  columnName: 'denumireFirma',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Denumire Firma'),
                  ),
                ),
                GridColumn(
                  columnName: 'certificatPDF',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Certificat PDF'),
                  ),
                ),
                GridColumn(
                  columnName: 'administrator',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Administrator'),
                  ),
                ),
                // Add more columns as needed for your model
              ],
            ),
    );
  }
}

class FirmeGestiuneDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Firmă"),
      content: FirmeGestiuneForm(),
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

class FirmeGestiuneForm extends StatefulWidget {
  @override
  State<FirmeGestiuneForm> createState() => _FirmeGestiuneFormState();
}

class _FirmeGestiuneFormState extends State<FirmeGestiuneForm> {
  final _formKey = GlobalKey<FormState>();
  final _numeController = TextEditingController();
  final _cuiController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final nume = _numeController.text.trim();
      final cui = _cuiController.text.trim();

      Map<String, dynamic> data = {
        'nume': nume,
        'cui': cui,
        // Add other fields as needed
      };

      await Provider.of<firmGestiuneProvider>(context, listen: false)
          .addFirm(context: context, data: data);

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
                maxLength: 50,
                controller: _numeController,
                decoration: _buildInputDecoration('Nume Firmă', Icons.business),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Nume Firmă';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 20,
                controller: _cuiController,
                decoration: _buildInputDecoration('CUI', Icons.code),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți CUI';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                      label: 'Adaugă Firmă',
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
void showFirmeGestiuneDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return FirmeGestiuneDialog();
    },
  );
}
