import 'package:factura_sys/models/status_Model.dart';
import 'package:factura_sys/provider/statusProvider.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/staticVar.dart';

class statusuri extends StatefulWidget {
  const statusuri({super.key});

  @override
  State<statusuri> createState() => _statusuriState();
}

class _statusuriState extends State<statusuri> {
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statusProviderVar = Provider.of<statusProvider>(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adaugă Status',
          backgroundColor: Color(0xFF3776B6),
          onPressed: () async {
            showStatusDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: !statusProviderVar.hasData
            ? staticVar.loading()
            : SfDataGrid(
                controller: _dataGridController,
                allowSorting: true,
                allowFiltering: true,
                columnWidthMode: ColumnWidthMode.fill,
                source: statusProviderVar.statusDataSources,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'status',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('Status'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'univers',
                    label: Container(
                      alignment: Alignment.center,
                      child: Text('Univers'),
                    ),
                  ),

                ],
              ));
  }
}

class StatusDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Status"),
      content: StatusForm(),
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

class StatusForm extends StatefulWidget {
  @override
  State<StatusForm> createState() => _StatusFormState();
}

class _StatusFormState extends State<StatusForm> {
  final _formKey = GlobalKey<FormState>();
  final _statusNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final status = _statusNameController.text.trim();
      final univers = _descriptionController.text.trim();
 
      Map<String, dynamic> data = {
        'status': status.trim(),
        'univers': univers.trim(),


      };

      await Provider.of<statusProvider>(context, listen: false)
          .addStatus(context: context, data: data);

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
                controller: _statusNameController,
                decoration: _buildInputDecoration('Status', Icons.label),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Nume Status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 100,
                controller: _descriptionController,
                decoration:
                    _buildInputDecoration('Univers', Icons.description),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Univers';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                      label: 'Adaugă Status',
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
void showStatusDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return StatusDialog();
    },
  );
}
