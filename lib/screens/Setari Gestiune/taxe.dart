import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/taxes_Model.dart';
import '../../provider/taxesProvider.dart';
import '../../widgets/buttons.dart';
import '../../models/staticVar.dart';

class taxe extends StatefulWidget {
  const taxe({super.key});

  @override
  State<taxe> createState() => _taxeState();
}

class _taxeState extends State<taxe> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    final taxesProvider = Provider.of<TaxesProvider>(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adaugă Taxă',
          backgroundColor: Color(0xFF3776B6),
          onPressed: () async {
            showTaxesDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: !taxesProvider.hasData
            ? staticVar.loading()
            : SfDataGrid(
          controller: _dataGridController,
          allowSorting: true,
          allowFiltering: true,
          columnWidthMode: ColumnWidthMode.fill,
          source: taxesProvider.taxesDataSource,
          columns: <GridColumn>[
            GridColumn(
              columnName: 'procentTaxa',
              label: Container(
                alignment: Alignment.center,
                child: Text('Procent Taxa'),
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
              columnName: 'denumire',
              label: Container(
                alignment: Alignment.center,
                child: Text('Denumire'),
              ),
            ),
          ],
        ));
  }
}

// Show dialog for adding a tax
void showTaxesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return TaxDialog();
    },
  );
}

class TaxDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Taxă"),
      content: TaxForm(),
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

class TaxForm extends StatefulWidget {
  @override
  State<TaxForm> createState() => _TaxFormState();
}

class _TaxFormState extends State<TaxForm> {
  final _formKey = GlobalKey<FormState>();
  final _procentTaxaController = TextEditingController();
  final _tipController = TextEditingController();
  final _denumireController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final procentTaxa = (double.tryParse(_procentTaxaController.text.trim() ?? "0.0") ?? 1.0) / 100;
      // final procentTaxa = _procentTaxaController.text.trim();
      final tip = _tipController.text.trim();
      final denumire = _denumireController.text.trim();

      Map<String, dynamic> data = {
        'procentTaxa': procentTaxa.toString(),
        'tip': tip,
        'denumire': denumire,
      };

      // Call the provider function to add the tax
      await Provider.of<TaxesProvider>(context, listen: false)
          .addTax(context: context, data: data);

      Navigator.of(context).pop(); // Close the dialog after submission
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelStyle: TextStyle(color: Color(0xFF444444)),
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)),
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
                maxLength: 3,
                controller: _procentTaxaController,
                decoration: _buildInputDecoration('Procent Taxa', Icons.percent),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Procentul Taxei';
                  }
                  final procent = int.tryParse(value);
                  if (procent == null || procent < 1 || procent > 100) {
                    return 'Introduceți un procent între 1 și 100';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 50,
                controller: _tipController,
                decoration: _buildInputDecoration('Tip', Icons.category),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Tipul Taxei';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 100,
                controller: _denumireController,
                decoration: _buildInputDecoration('Denumire', Icons.label),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Denumirea Taxei';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                label: 'Adaugă Taxă',
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to show the dialog for adding a tax
void showTaxDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Adaugă Taxă"),
        content: TaxForm(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Anulează"),
          ),
        ],
      );
    },
  );
}

