
import 'package:factura_sys/provider/IntrariProvider.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/intrariService_Model.dart';
import '../../models/staticVar.dart';

class intrariService extends StatefulWidget {
  const intrariService({super.key});

  @override
  State<intrariService> createState() => _intrariServiceState();
}

class _intrariServiceState extends State<intrariService> {
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final intrariServiceProvider = Provider.of<IntrariProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă intrare',
        backgroundColor:  staticVar.themeColor,
        onPressed: () async {
          //showIntrariServiceDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: !intrariServiceProvider.hasData
           ? staticVar.loading()
          : SfDataGrid(
        controller: _dataGridController,
        allowSorting: true,
        allowFiltering: true,
        columnWidthMode: ColumnWidthMode.auto,
        source: intrariServiceProvider.intrariDataSources,
        columns: <GridColumn> [
          GridColumn(
            columnName: 'idIntrareService',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Intrare Service'),
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
            columnName: 'cuiService',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Service'),
            ),
          ),
          GridColumn(
            columnName: 'denumireService',
            label: Container(
              alignment: Alignment.center,
              child: Text('Denumire Service'),
            ),
          ),
          GridColumn(
            columnName: 'motiv',
            label: Container(
              alignment: Alignment.center,
              child: Text('Motiv'),
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
            columnName: 'constatare',
            label: Container(
              alignment: Alignment.center,
              child: Text('Constatare'),
            ),
          ),
          GridColumn(
            columnName: 'fisierDeviz',
            label: Container(
              alignment: Alignment.center,
              child: Text('Fișier Deviz'),
            ),
          ),
        ],
      ),
    );
  }
}

class IntrariServiceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Intrare Serviciu"),
      content: IntrariServiceForm(),
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

class IntrariServiceForm extends StatefulWidget {
  @override
  State<IntrariServiceForm> createState() => _IntrariServiceFormState();
}

class _IntrariServiceFormState extends State<IntrariServiceForm> {
  final _formKey = GlobalKey<FormState>();
  final _idServiceController = TextEditingController();
  final _numeServiciuController = TextEditingController();
  final _cuiFurnizorController = TextEditingController();
  final _costController = TextEditingController();
  String _moneda = 'RON';
  DateTime? _dataIntrare;
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
        _dataIntrare = pickedDate;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      final idService = _idServiceController.text.trim();
      final numeServiciu = _numeServiciuController.text.trim();
      final cuiFurnizor = _cuiFurnizorController.text.trim();
      final cost = _costController.text.isNotEmpty
          ? double.tryParse(_costController.text.trim())
          : null;
      User? user = FirebaseAuth.instance.currentUser;

      Map<String, dynamic> data = {
        'idService': idService,
        'numeServiciu': numeServiciu,
        'cuiFurnizor': cuiFurnizor,
        'dataIntrare': _dataIntrare,
        'cost': cost ?? 0.0,
        'moneda': _moneda,
        'timestamp': DateTime.now(),
        'userEmail': user!.email,
      };

      // await Provider.of<IntrariServiceProvider>(context, listen: false)
      //     .addIntrariService(context: context, data: data);

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
                controller: _idServiceController,
                decoration: _buildInputDecoration('ID Serviciu', Icons.label),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți ID Serviciu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _numeServiciuController,
                decoration: _buildInputDecoration('Nume Serviciu', Icons.business),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Numele Serviciului';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _cuiFurnizorController,
                decoration: _buildInputDecoration('CUI Furnizor', Icons.person),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți CUI Furnizor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _costController,
                decoration: _buildInputDecoration('Cost', Icons.money),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && !RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(value)) {
                    return 'Introduceți o valoare numerică validă';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _moneda,
                decoration: _buildInputDecoration('Moneda', Icons.attach_money),
                items: ['RON', 'EUR', 'USD'].map((String value) {
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
              TextButton(
                onPressed: () => _pickDate(context),
                child: Text(_dataIntrare == null
                    ? 'Alegeți Data Intrare'
                    : 'Data: ${_dataIntrare!.toLocal()}'),
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                label: 'Adaugă Intrare Serviciu',
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
void showIntrariServiceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => IntrariServiceDialog(),
  );
}
