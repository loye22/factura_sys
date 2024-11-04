import 'package:factura_sys/models/gestinueMasini_Model.dart';
import 'package:factura_sys/provider/gestiuneMasiniProvider.dart';
import 'package:factura_sys/widgets/CustomDropdown.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:factura_sys/widgets/gestiuneMasiniDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../models/staticVar.dart';
import '../../provider/entitatiProvider.dart';

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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold( key: _scaffoldKey, // Ass
        endDrawer: gestiuneMasiniDrawer(),
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adaugă Mașină',
          backgroundColor: staticVar.themeColor,
          onPressed: () async {
            _scaffoldKey.currentState?.openEndDrawer();
          //    Scaffold.of(context).openEndDrawer();
            // showMasinaFrom(context);
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
                columns: <GridColumn>[
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

class MasinaDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Mașină"),
      content: MasinaForm(),
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

class MasinaForm extends StatefulWidget {
  @override
  State<MasinaForm> createState() => _MasinaFormState();
}

class _MasinaFormState extends State<MasinaForm> {
  final _formKey = GlobalKey<FormState>();
  final _serieSasiuController = TextEditingController();
  final _cuiProprietarController = TextEditingController();
  final _comodatController = TextEditingController();
  final _numarInmatricularController = TextEditingController();
  final _marcaMasinaController = TextEditingController();
  final _modelController = TextEditingController();
  final _anulController = TextEditingController();
  final _utilizatorController = TextEditingController();
  final _kilometrajController = TextEditingController();
  final _tipCombustibilController = TextEditingController();
  final _responsabilController = TextEditingController();
  final _valoareAchizitieController = TextEditingController();
  final _monedaController = TextEditingController();

  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final serieSasiu = _serieSasiuController.text.trim();
      final cuiProprietar = _cuiProprietarController.text.trim();
      final comodat = _comodatController.text.trim();
      final numarInmatricular = _numarInmatricularController.text.trim();
      final marcaMasina = _marcaMasinaController.text.trim();
      final model = _modelController.text.trim();
      final anul = _anulController.text.trim();
      final utilizator = _utilizatorController.text.trim();
      final kilometraj = _kilometrajController.text.isNotEmpty
          ? int.tryParse(_kilometrajController.text.trim())
          : null;
      final tipCombustibil = _tipCombustibilController.text.trim();
      final responsabil = _responsabilController.text.trim();
      final valoareAchizitie = _valoareAchizitieController.text.isNotEmpty
          ? double.tryParse(_valoareAchizitieController.text.trim())
          : null;
      final moneda = _monedaController.text.trim();

      // Prepare the data to be added
      Map<String, dynamic> data = {
        'serieSasiu': serieSasiu,
        'cuiProprietar': cuiProprietar,
        'comodat': comodat,
        'numarInmatricular': numarInmatricular,
        'marcaMasina': marcaMasina,
        'model': model,
        'anul': anul,
        'utilizator': utilizator,
        'kilometraj': kilometraj ?? 0,
        'tipCombustibil': tipCombustibil,
        'responsabil': responsabil,
        'valoareAchizitie': valoareAchizitie ?? 0.0,
        'moneda': moneda,
        'timestamp': DateTime.now(),
      };

      // Access the provider and call the addMasina method
      // await Provider.of<gestinueMasiniProvider>(context, listen: false)
      //     .addMasina(context: context, data: data);

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

  String? cuiSelectedValue;
  String? comodataSelectedValue ;

  @override
  Widget build(BuildContext context) {
    final entitatiProvider = Provider.of<EntitatiProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _serieSasiuController,
                decoration:
                    _buildInputDecoration('Serie Șasiu', Icons.directions_car),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Serie Șasiu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              entitatiProvider.hasData
                  ? CustomDropdown(
                      selectedValue: cuiSelectedValue,
                      items: entitatiProvider.entitatiList
                          .map((e) => e.cuiEntitate)
                          .toList()
                          .toSet()
                          .toList(),
                      textEditingController: _cuiProprietarController,
                      onAddNewItemPressed: () {},
                      hint: 'CUI Proprietar',
                      hintIcon: Icons.business,
                      onChanged: (value) {
                        print('here is the value ');
                        print("value ---> " + value.toString());
                        print("type ---> " + value.runtimeType.toString());
                        setState(() {
                          cuiSelectedValue = value;
                        });
                      })
                  : staticVar.loading(),

              SizedBox(height: 20),
              entitatiProvider.hasData
                  ? CustomDropdown(
                      selectedValue: comodataSelectedValue,
                      items: entitatiProvider.entitatiList
                          .map((e) => e.denumire)
                          .toList()
                          .toSet()
                          .toList(),
                      textEditingController: _comodatController,
                      onAddNewItemPressed: () {},
                      hint: 'Comodat',
                      hintIcon:Icons.handshake,
                      onChanged: (value) {
                        setState(() {
                          cuiSelectedValue = value;
                        });
                      })
                  : staticVar.loading(),

              SizedBox(height: 20),
              TextFormField(
                controller: _numarInmatricularController,
                decoration: _buildInputDecoration(
                    'Număr Înmatricular', Icons.directions_car),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _marcaMasinaController,
                decoration: _buildInputDecoration(
                    'Marca Mașină', Icons.directions_car_filled),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _modelController,
                decoration:
                    _buildInputDecoration('Model', Icons.model_training),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _anulController,
                decoration: _buildInputDecoration('Anul', Icons.calendar_today),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Anul';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _utilizatorController,
                decoration: _buildInputDecoration('Utilizator', Icons.person),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _kilometrajController,
                decoration: _buildInputDecoration('Kilometraj', Icons.speed),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      int.tryParse(value) == null) {
                    return 'Introduceți o valoare numerică validă';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _tipCombustibilController,
                decoration: _buildInputDecoration(
                    'Tip Combustibil', Icons.local_gas_station),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _responsabilController,
                decoration: _buildInputDecoration('Responsabil', Icons.person),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _valoareAchizitieController,
                decoration:
                    _buildInputDecoration('Valoare Achiziție', Icons.money),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _monedaController,
                decoration: _buildInputDecoration('Moneda', Icons.attach_money),
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                      label: 'Adaugă Mașină',
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
void showMasinaFrom(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return MasinaDialog();
    },
  );
}
