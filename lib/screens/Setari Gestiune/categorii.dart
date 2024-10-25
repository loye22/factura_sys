import 'package:factura_sys/models/categorie_Model.dart';
import 'package:factura_sys/provider/categorieProvider.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/staticVar.dart';

class categorii extends StatefulWidget {
  const categorii({super.key});

  @override
  State<categorii> createState() => _categoriiState();
}

class _categoriiState extends State<categorii> {
  final DataGridController _dataGridController = DataGridController();
  late categorieDataSource _categorieDataSource;

  @override
  Widget build(BuildContext context) {
    final categoriiiProvider = Provider.of<categorieProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Categorie',
        backgroundColor: Color(0xFF3776B6),
        onPressed: () async {
          showCategorieDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: !categoriiiProvider.hasData
          ? staticVar.loading()
          : SfDataGrid(
              controller: _dataGridController,
              allowSorting: true,
              allowFiltering: true,
              columnWidthMode: ColumnWidthMode.fill,
              source: categoriiiProvider.categorieDataSources,
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'categorieTag',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Categorie Tag'),
                  ),
                ),
              ],
            ),
    );
  }
}

class CategorieForm extends StatefulWidget {
  @override
  State<CategorieForm> createState() => _CategorieFormState();
}

class _CategorieFormState extends State<CategorieForm> {
  final _formKey = GlobalKey<FormState>();
  final _categorieTagController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final categorieTag = _categorieTagController.text.trim();

      await Provider.of<categorieProvider>(context, listen: false)
          .addCategorie(context: context, data: {'categorieTag': categorieTag});

      Navigator.of(context).pop(); // Close the dialog after submission
      setState(() {
        isLoading = false;
      });
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
      width: MediaQuery.of(context).size.width * .3,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _categorieTagController,
                decoration: _buildInputDecoration('Categorie Tag', Icons.label),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Categorie Tag';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                      onPressed: _submitForm,
                      label: 'Adaugă Categorie',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to show the dialog for adding a Categorie
void showCategorieDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Adaugă Categorie"),
        content: CategorieForm(),
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
