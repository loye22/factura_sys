
import 'package:factura_sys/models/gestinueMasini_Model.dart';
import 'package:factura_sys/provider/gestiuneMasiniProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/staticVar.dart';

class gestiuneMasini extends StatefulWidget {
  const gestiuneMasini({super.key});

  @override
  State<gestiuneMasini> createState() => _gestiuneMasiniState();
}

class _gestiuneMasiniState extends State<gestiuneMasini> {
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gestinueProviderVar = Provider.of<gestinueMasiniProvider>(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adaugă Mașină',
          backgroundColor: Color(0xFF3776B6),
          onPressed: () async {
           // showGestinueDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: !gestinueProviderVar.hasData
            ? staticVar.loading()
            : SfDataGrid(
          controller: _dataGridController,
          allowSorting: true,
          allowFiltering: true,
          columnWidthMode: ColumnWidthMode.auto,
          source: gestinueProviderVar.masiniDataSources,
          columns: <GridColumn> [
            GridColumn(
              columnName: 'serieSasiu',
              label: Container(
                alignment: Alignment.center,
                child: Text('Serie Șasiu'),
              ),
            ),
            GridColumn(
              columnName: 'cuiProprietar',
              label: Container(
                alignment: Alignment.center,
                child: Text('CUI Proprietar'),
              ),
            ),
            GridColumn(
              columnName: 'proprietar',
              label: Container(
                alignment: Alignment.center,
                child: Text('Proprietar'),
              ),
            ),
            GridColumn(
              columnName: 'comodat',
              label: Container(
                alignment: Alignment.center,
                child: Text('Comodat'),
              ),
            ),
            GridColumn(
              columnName: 'numarInmatricular',
              label: Container(
                alignment: Alignment.center,
                child: Text('Număr Înmatricular'),
              ),
            ),
            GridColumn(
              columnName: 'marcaMasina',
              label: Container(
                alignment: Alignment.center,
                child: Text('Marcă Mașină'),
              ),
            ),
            GridColumn(
              columnName: 'modelModel',
              label: Container(
                alignment: Alignment.center,
                child: Text('Model'),
              ),
            ),
            GridColumn(
              columnName: 'anul',
              label: Container(
                alignment: Alignment.center,
                child: Text('Anul'),
              ),
            ),
            GridColumn(
              columnName: 'utilizator',
              label: Container(
                alignment: Alignment.center,
                child: Text('Utilizator'),
              ),
            ),
            GridColumn(
              columnName: 'kilometraj',
              label: Container(
                alignment: Alignment.center,
                child: Text('Kilometraj'),
              ),
            ),
            GridColumn(
              columnName: 'tipCombustibil',
              label: Container(
                alignment: Alignment.center,
                child: Text('Tip Combustibil'),
              ),
            ),
            GridColumn(
              columnName: 'valabilitateRCA',
              label: Container(
                alignment: Alignment.center,
                child: Text('Valabilitate RCA'),
              ),
            ),
            GridColumn(
              columnName: 'valabilitateITP',
              label: Container(
                alignment: Alignment.center,
                child: Text('Valabilitate ITP'),
              ),
            ),
            GridColumn(
              columnName: 'valabilitateROVINIETA',
              label: Container(
                alignment: Alignment.center,
                child: Text('Valabilitate ROVINIETA'),
              ),
            ),
            GridColumn(
              columnName: 'valabilitateCASCO',
              label: Container(
                alignment: Alignment.center,
                child: Text('Valabilitate CASCO'),
              ),
            ),
            GridColumn(
              columnName: 'responsabil',
              label: Container(
                alignment: Alignment.center,
                child: Text('Responsabil'),
              ),
            ),
            GridColumn(
              columnName: 'valoareAchizitie',
              label: Container(
                alignment: Alignment.center,
                child: Text('Valoare Achiziție'),
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
              columnName: 'intrariService',
              label: Container(
                alignment: Alignment.center,
                child: Text('Intrări Service'),
              ),
            ),
            GridColumn(
              columnName: 'cheltuieliService',
              label: Container(
                alignment: Alignment.center,
                child: Text('Cheltuieli Service'),
              ),
            ),
          ],
        ));
  }
}

class GestinueDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Mașină"),
      content: GestinueForm(),
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

class GestinueForm extends StatefulWidget {
  @override
  State<GestinueForm> createState() => _GestinueFormState();
}

class _GestinueFormState extends State<GestinueForm> {
  final _formKey = GlobalKey<FormState>();
  final _serieSasiuController = TextEditingController();
  final _cuiProprietarController = TextEditingController();
  final _proprietarController = TextEditingController();
  final _comodatController = TextEditingController();
  final _numarInmatricularController = TextEditingController();
  final _marcaMasinaController = TextEditingController();
  final _modelController = TextEditingController();
  final _anController = TextEditingController();
  final _utilizatorController = TextEditingController();
  final _kilometrajController = TextEditingController();

  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final data = {
        'serieSasiu': _serieSasiuController.text.trim(),
        'cuiProprietar': _cuiProprietarController.text.trim(),
        'proprietar': _proprietarController.text.trim(),
        'comodat': _comodatController.text.trim(),
        'numarInmatricular': _numarInmatricularController.text.trim(),
        'marcaMasina': _marcaMasinaController.text.trim(),
        'model': _modelController.text.trim(),
        'an': _anController.text.trim(),
        'utilizator': _utilizatorController.text.trim(),
        'kilometraj': _kilometrajController.text.trim(),
        'timestamp': DateTime.now(),
        'userEmail': FirebaseAuth.instance.currentUser?.email,
      };

      // await Provider.of<GestinueMasiniProvider>(context, listen: false)
      //     .addGestinue(data);

      Navigator.of(context).pop(); // Close the dialog after submission
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _serieSasiuController,
            decoration: _buildInputDecoration('Serie Șasiu', Icons.car_repair),
            validator: (value) => value!.isEmpty ? 'Introduceți Serie Șasiu' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _cuiProprietarController,
            decoration: _buildInputDecoration('CUI Proprietar', Icons.business),
            validator: (value) => value!.isEmpty ? 'Introduceți CUI Proprietar' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _proprietarController,
            decoration: _buildInputDecoration('Proprietar', Icons.person),
            validator: (value) => value!.isEmpty ? 'Introduceți Proprietar' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _comodatController,
            decoration: _buildInputDecoration('Comodat', Icons.assignment),
            validator: (value) => value!.isEmpty ? 'Introduceți Comodat' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _numarInmatricularController,
            decoration: _buildInputDecoration('Număr Înmatriculare', Icons.confirmation_number),
            validator: (value) => value!.isEmpty ? 'Introduceți Numărul de Înmatriculare' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _marcaMasinaController,
            decoration: _buildInputDecoration('Marca Mașină', Icons.local_car_wash),
            validator: (value) => value!.isEmpty ? 'Introduceți Marca Mașină' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _modelController,
            decoration: _buildInputDecoration('Model', Icons.text_fields),
            validator: (value) => value!.isEmpty ? 'Introduceți Model' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _anController,
            decoration: _buildInputDecoration('An', Icons.calendar_today),
            validator: (value) => value!.isEmpty ? 'Introduceți An' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _utilizatorController,
            decoration: _buildInputDecoration('Utilizator', Icons.person_add),
            validator: (value) => value!.isEmpty ? 'Introduceți Utilizator' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _kilometrajController,
            decoration: _buildInputDecoration('Kilometraj', Icons.speed),
            validator: (value) => value!.isEmpty ? 'Introduceți Kilometraj' : null,
          ),
          SizedBox(height: 20),
          isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
            onPressed: _submitForm,
            child: Text('Salvează'),
          ),
        ],
      ),
    );
  }
}
