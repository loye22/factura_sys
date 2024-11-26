
import 'package:factura_sys/provider/politeProvider.dart';
import 'package:factura_sys/widgets/buttons.dart'; // Custom button widget
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
        backgroundColor: staticVar.themeColor ,
        onPressed: () async {
          showPolitieForm(context);
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

 class PolitieDialog extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return AlertDialog(
       title: Text("Adaugă Poliță Asigurare"),
       content: PolitieForm(),
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

 class PolitieForm extends StatefulWidget {
   @override
   State<PolitieForm> createState() => _PolitieFormState();
 }

 class _PolitieFormState extends State<PolitieForm> {
   final _formKey = GlobalKey<FormState>();

   final _serieSasiuController = TextEditingController();
   final _numarInmatricularController = TextEditingController();
   final _marcaController = TextEditingController();
   final _modelController = TextEditingController();
   final _cuiFurnizorController = TextEditingController();
   final _numeFurnizorController = TextEditingController();
   final _idFacturaController = TextEditingController();
   final _totalPlataController = TextEditingController();
   final _statusPlataController = TextEditingController();
   final _fisierPolitaController = TextEditingController();

   String? tipPolitaSelectedValue;
   DateTime? _valabilitateDeLa;
   DateTime? _valabilitatePanaLa;

   bool isLoading = false;

   Future<void> _submitForm() async {
     try {
       if (_formKey.currentState!.validate()) {
         setState(() {
           isLoading = true;
         });

         final serieSasiu = _serieSasiuController.text.trim();
         final numarInmatricular = _numarInmatricularController.text.trim();
         final marca = _marcaController.text.trim();
         final model = _modelController.text.trim();
         final cuiFurnizor = _cuiFurnizorController.text.trim();
         final numeFurnizor = _numeFurnizorController.text.trim();
         final idFactura = _idFacturaController.text.trim();
         final totalPlata = _totalPlataController.text.isNotEmpty
             ? double.tryParse(_totalPlataController.text.trim())
             : null;
         final statusPlata = _statusPlataController.text.trim();
         final fisierPolita = _fisierPolitaController.text.trim();

         // Prepare the data to be added
         Map<String, dynamic> data = {
           'Tip Polita': tipPolitaSelectedValue,
           'Serie Sasiu': serieSasiu,
           'Numar Inmatriculare': numarInmatricular,
           'Marca': marca,
           'Model': model,
           'CUI Furnizor': cuiFurnizor,
           'Nume Furnizor': numeFurnizor,
           'Valabilitate De la': _valabilitateDeLa?.toString(),
           'Valabilitate Pana la': _valabilitatePanaLa?.toString(),
           'ID Factura': idFactura,
           'Total Plata': totalPlata ?? 0.0,
           'Status Plata': statusPlata,
           'Fisier Polita': fisierPolita,
         };

         // Access the provider and call the addPolitie method
         // await Provider.of<PolitieProvider>(context, listen: false)
         //     .addPolitie(context: context, data: data);
         Navigator.of(context).pop();
       }
     } catch (e) {
       print("Error $e");
     } finally {
       isLoading = false;
       setState(() {});
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
       width: MediaQuery.of(context).size.width * 0.3,
       child: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(16.0),
           child: Form(
             key: _formKey,
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _serieSasiuController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('Serie Șasiu', Icons.directions_car
                   ),
                   validator: (value) {
                     if (value == null || value.trim().isEmpty) {
                       return 'Introduceți Serie Șasiu';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _numarInmatricularController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('Număr Înmatriculare', Icons.confirmation_number
                   ),
                   validator: (value) {
                     if (value == null || value.trim().isEmpty) {
                       return 'Introduceți Număr Înmatriculare';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _marcaController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('Marca', Icons.car_repair

                   ),
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _modelController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('Model',Icons.style
                   ),
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _cuiFurnizorController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('CUI Furnizor', Icons.business
                   ),
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _numeFurnizorController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('Nume Furnizor', Icons.account_circle
                   ),
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _idFacturaController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('ID Factura', Icons.file_copy),
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _totalPlataController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('Total Plata', Icons.attach_money),
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _statusPlataController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('Status Plata', Icons.check_circle),
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   controller: _fisierPolitaController,
                   maxLength: 30,
                   decoration: _buildInputDecoration('Fisier Polita', Icons.file_upload),
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   decoration: _buildInputDecoration('Valabilitate De la', Icons.calendar_today),
                   readOnly: true,
                   onTap: () async {
                     DateTime? selectedDate = await showDatePicker(
                       context: context,
                       initialDate: _valabilitateDeLa ?? DateTime.now(),
                       firstDate: DateTime(2000),
                       lastDate: DateTime(2101),
                     );
                     if (selectedDate != null) {
                       setState(() {
                         _valabilitateDeLa = selectedDate;
                       });
                     }
                   },
                   validator: (value) {
                     if (_valabilitateDeLa == null) {
                       return 'Introduceți Valabilitate De la';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 20),
                 TextFormField(
                   decoration: _buildInputDecoration('Valabilitate Pana la', Icons.calendar_today),
                   readOnly: true,
                   onTap: () async {
                     DateTime? selectedDate = await showDatePicker(
                       context: context,
                       initialDate: _valabilitatePanaLa ?? DateTime.now(),
                       firstDate: DateTime(2000),
                       lastDate: DateTime(2101),
                     );
                     if (selectedDate != null) {
                       setState(() {
                         _valabilitatePanaLa = selectedDate;
                       });
                     }
                   },
                   validator: (value) {
                     if (_valabilitatePanaLa == null) {
                       return 'Introduceți Valabilitate Pana la';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 30),
                 isLoading
                     ? CircularProgressIndicator()
                     : CustomButtons(
                   label: 'Adaugă Poliță',
                   onPressed: _submitForm,
                 ),
               ],
             ),
           ),
         ),
       ),
     );
   }
 }

 // Function to show the dialog
 void showPolitieForm(BuildContext context) {
   showDialog(
     context: context,
     builder: (context) {
       return PolitieDialog();
     },
   );
 }

