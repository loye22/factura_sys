
 import 'package:factura_sys/models/polite_Model.dart';
import 'package:factura_sys/provider/politeProvider.dart';
import 'package:factura_sys/widgets/buttons.dart'; // Custom button widget
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/staticVar.dart'; // Import your static variables

// Main widget for displaying the polite dialog and data grid
class polite extends StatefulWidget {
  const polite({super.key});

  @override
  State<polite> createState() => _politeState();
}

// State for PoliteUri
class _politeState extends State<polite> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    final politeProviderVar = Provider.of<politeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      // Floating action button to add new polite
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă polite',
        backgroundColor:  staticVar.themeColor,
        onPressed: () async {
          // showPoliteDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      // Displaying the data grid
      body: !politeProviderVar.hasData
          ? staticVar.loading()
          : SfDataGrid(
        controller: _dataGridController,
        allowSorting: true,
        allowFiltering: true,
        columnWidthMode: ColumnWidthMode.auto,
        source: politeProviderVar.politeDataSources,
        columns: <GridColumn> [
          GridColumn(
            columnName: 'idPolitaAsigurari',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Poliță Asigurare'),
            ),
          ),
          GridColumn(
            columnName: 'tipPolita',
            label: Container(
              alignment: Alignment.center,
              child: Text('Tip Poliță'),
            ),
          ),
          GridColumn(
            columnName: 'serieSasiu',
            label: Container(
              alignment: Alignment.center,
              child: Text('Serie Șasiu'),
            ),
          ),
          GridColumn(
            columnName: 'numarInmatriculare',
            label: Container(
              alignment: Alignment.center,
              child: Text('Număr Înmatriculare'),
            ),
          ),
          GridColumn(
            columnName: 'marca',
            label: Container(
              alignment: Alignment.center,
              child: Text('Marcă'),
            ),
          ),
          GridColumn(
            columnName: 'model',
            label: Container(
              alignment: Alignment.center,
              child: Text('Model'),
            ),
          ),
          GridColumn(
            columnName: 'cuiFurnizor',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Furnizor'),
            ),
          ),
          GridColumn(
            columnName: 'numeFurnizor',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Furnizor'),
            ),
          ),
          GridColumn(
            columnName: 'valabilitateDeLa',
            label: Container(
              alignment: Alignment.center,
              child: Text('Valabilitate De La'),
            ),
          ),
          GridColumn(
            columnName: 'valabilitatePanaLa',
            label: Container(
              alignment: Alignment.center,
              child: Text('Valabilitate Până La'),
            ),
          ),
          GridColumn(
            columnName: 'idFactura',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Factură'),
            ),
          ),
          GridColumn(
            columnName: 'totalPlata',
            label: Container(
              alignment: Alignment.center,
              child: Text('Total Plata'),
            ),
          ),
          GridColumn(
            columnName: 'statusPlata',
            label: Container(
              alignment: Alignment.center,
              child: Text('Status Plata'),
            ),
          ),
          GridColumn(
            columnName: 'fisierPolita',
            label: Container(
              alignment: Alignment.center,
              child: Text('Fișier Poliță'),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to show the polite dialog
void showPoliteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return PoliteDialog();
    },
  );
}

// Dialog widget for adding new polite
class PoliteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă polite"),
      content: PoliteForm(), // Form for inputting polite data
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

// Form widget for adding polite
class PoliteForm extends StatefulWidget {
  @override
  State<PoliteForm> createState() => _PoliteFormState();
}

class _PoliteFormState extends State<PoliteForm> {
  final _formKey = GlobalKey<FormState>();
  final _numeClientController = TextEditingController();
  final _dataEmitereController = TextEditingController();
  final _totalController = TextEditingController();
  bool isLoading = false;

  // Function to submit the form
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Collecting input data
      final numeClient = _numeClientController.text.trim();
      final dataEmitere = _dataEmitereController.text.trim();
      final total = double.tryParse(_totalController.text.trim()) ?? 0.0;
      User? user = FirebaseAuth.instance.currentUser;

      // Prepare the data to be added
      Map<String, dynamic> data = {
        'numeClient': numeClient,
        'dataEmitere': dataEmitere,
        'total': total,
        'timestamp': DateTime.now(),
        'userEmail': user!.email,
      };

      // Access the provider and call the addPolite method
      // await Provider.of<politeProvider>(context, listen: false)
      //     .addPolite(context: context, data: data);

      Navigator.of(context).pop(); // Close the dialog after submission
    }
  }

  // Function to build input decoration for text fields
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
                controller: _numeClientController,
                decoration: _buildInputDecoration('Nume Client', Icons.person),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți numele clientului';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _dataEmitereController,
                decoration: _buildInputDecoration('Data Emitere', Icons.date_range),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți data emiterii';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _totalController,
                decoration: _buildInputDecoration('Total', Icons.money),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți totalul';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                label: 'Adaugă polite',
                onPressed: _submitForm, // Submit the form
              ),
            ],
          ),
        ),
      ),
    );
  }
}
