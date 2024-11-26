import 'package:factura_sys/models/gestinueMasini_Model.dart';
import 'package:factura_sys/provider/ModedaProvider.dart';
import 'package:factura_sys/provider/gestiuneMasiniProvider.dart';
import 'package:factura_sys/provider/marcaMasinaProvider.dart';
import 'package:factura_sys/provider/modelMasinaProvider.dart';
import 'package:factura_sys/provider/tipuriProvider.dart';
import 'package:factura_sys/widgets/CustomDropdown.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:factura_sys/widgets/gestiuneMasiniDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
    // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        // key: _scaffoldKey, // Ass
        endDrawer: gestiuneMasiniDrawer(),
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adaugă Mașină',
          backgroundColor: staticVar.themeColor,
          onPressed: () async {
            //  _scaffoldKey.currentState?.openEndDrawer();
            //    Scaffold.of(context).openEndDrawer();
            showMasinaFrom(context);
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
  final _numarInmatricularController = TextEditingController();
  final _utilizatorController = TextEditingController();
  final _kilometrajController = TextEditingController();
  final _responsabilController = TextEditingController();
  final _valoareAchizitieController = TextEditingController();
  final _anulController = TextEditingController();

  String? cuiSelectedValue;
  String? comodataSelectedValue;
  String? MarcaMasinaSelectedValue;
  String? modelSelectedValue;
  String? tipuriSelectedValue;
  String? monedaSelectedValue;
  DateTime? _selectedDate;

  bool isLoading = false;

  Future<void> _submitForm() async {
    try {
      print('before if');
      print(_formKey.currentState!.validate());
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        final serieSasiu = _serieSasiuController.text.trim();
        final cuiProprietar = cuiSelectedValue;
        final comodat = comodataSelectedValue;
        final numarInmatricular = _numarInmatricularController.text.trim();
        final marcaMasina = MarcaMasinaSelectedValue;
        final model = modelSelectedValue;
        final utilizator = _utilizatorController.text.trim();
        final kilometraj = _kilometrajController.text.isNotEmpty
            ? int.tryParse(_kilometrajController.text.trim())
            : null;
        final tipCombustibil = tipuriSelectedValue;
        final responsabil = _responsabilController.text.trim();
        final valoareAchizitie = _valoareAchizitieController.text.isNotEmpty
            ? double.tryParse(_valoareAchizitieController.text.trim())
            : null;
        final moneda = monedaSelectedValue;

        // Prepare the data to be added
        Map<String, dynamic> data = {
          'Serie Sasiu': serieSasiu,
          'CUI Proprietar': cuiProprietar,
          'Comodat': comodat,
          'Numar Inmatricular': numarInmatricular,
          'Marca Masina': marcaMasina,
          'Model Model': model,
          'Anul': _anulController.text,
          'Utilizator': utilizator,
          'Kilometraj': kilometraj ?? 0,
          'Tip Combustibil': tipCombustibil,
          'Responsabil': responsabil,
          'Valoare Achizitie': valoareAchizitie ?? 0.0,
          'Moneda': moneda,
          //'timestamp': DateTime.now().toString(),
        };

        // Access the provider and call the addMasina method
        await Provider.of<gestinueMasiniProvider>(context, listen: false)
            .addMasina(context: context, data: data);
        Navigator.of(context).pop();

        //  Navigator.of(context).pop(); // Close the dialog after submission
      }
    }
    catch(e){
      print("Error $e");
    }
    finally{
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
  @override
  Widget build(BuildContext context) {
    final entitatiProvider = Provider.of<EntitatiProvider>(context);
    final MarcaProvider = Provider.of<MarcaMasinaProvider>(context);
    final modelProvider = Provider.of<modelMasinaProvider>(context);
    final tipuriProvider = Provider.of<TipuriProvider>(context);
    final monedaProvider = Provider.of<ModedaProvider>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: (monedaProvider.hasData &&
                    tipuriProvider.hasData &&
                    modelProvider.hasData &&
                    MarcaProvider.hasData &&
                    entitatiProvider.hasData)
                ? Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 30,
                          controller: _serieSasiuController,
                          decoration: _buildInputDecoration(
                              'Serie Șasiu', Icons.directions_car),
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
                                textEditingController: TextEditingController(),
                                selectedValue: cuiSelectedValue,
                                items: entitatiProvider.entitatiList
                                    .map((e) => e.cuiEntitate)
                                    .toList()
                                    .toSet()
                                    .toList(),
                                onAddNewItemPressed: () {},
                                hint: 'CUI Proprietar',
                                hintIcon: Icons.business,
                                onChanged: (value) {
                                  setState(() {
                                    cuiSelectedValue = value;
                                  });
                                })
                            : staticVar.loading(),
                        SizedBox(height: 20),
                        entitatiProvider.hasData
                            ? CustomDropdown(
                                textEditingController: TextEditingController(),
                                selectedValue: comodataSelectedValue,
                                items: entitatiProvider.entitatiList
                                    .map((e) => e.denumire)
                                    .toList()
                                    .toSet()
                                    .toList(),
                                onAddNewItemPressed: () {},
                                hint: 'Comodat',
                                hintIcon: Icons.handshake,
                                onChanged: (value) {
                                  setState(() {
                                    comodataSelectedValue = value;
                                  });
                                })
                            : staticVar.loading(),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 30,
                          controller: _numarInmatricularController,
                          decoration: _buildInputDecoration(
                              'Număr Înmatricular', Icons.directions_car),
                        ),
                        SizedBox(height: 20),
                        MarcaProvider.hasData
                            ? CustomDropdown(
                                textEditingController: TextEditingController(),
                                selectedValue: MarcaMasinaSelectedValue,
                                items: MarcaProvider.marcaMasinaList
                                    .map((e) => e.marcaMasina)
                                    .toList()
                                    .toSet()
                                    .toList(),
                                onAddNewItemPressed: () {},
                                hint: 'Marca Mașină',
                                hintIcon: Icons.directions_car_filled,
                                onChanged: (value) {
                                  setState(() {
                                    MarcaMasinaSelectedValue = value;
                                  });
                                })
                            : staticVar.loading(),
                        SizedBox(height: 20),
                        modelProvider.hasData
                            ? CustomDropdown(
                                textEditingController: TextEditingController(),
                                selectedValue: modelSelectedValue,
                                items: modelProvider.modelMasinaList
                                    .map((e) => e.model)
                                    .toList()
                                    .toSet()
                                    .toList(),
                                onAddNewItemPressed: () {},
                                hint: 'Model',
                                hintIcon: Icons.car_rental,
                                onChanged: (value) {
                                  setState(() {
                                    modelSelectedValue = value;
                                  });
                                })
                            : staticVar.loading(),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _anulController,
                          maxLength: 4,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          // Makes the TextFormField read-only
                          decoration: _buildInputDecoration(
                              'Anul', Icons.calendar_today),

                          // Show date picker on tap
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Introduceți Anul';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 30,
                          controller: _utilizatorController,
                          decoration:
                              _buildInputDecoration('Utilizator', Icons.person),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 4,
                          controller: _kilometrajController,
                          decoration:
                              _buildInputDecoration('Kilometraj', Icons.speed),
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
                        tipuriProvider.hasData
                            ? CustomDropdown(
                                selectedValue: tipuriSelectedValue,
                                items: tipuriProvider.tipuriList
                                    .map((e) => e.tip)
                                    .toList()
                                    .toSet()
                                    .toList(),
                                textEditingController: TextEditingController(),
                                onAddNewItemPressed: () {},
                                hint: 'Tip Combustibil',
                                hintIcon: Icons.local_gas_station,
                                onChanged: (value) {
                                  setState(() {
                                    tipuriSelectedValue = value;
                                  });
                                })
                            : staticVar.loading(),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 30,
                          controller: _responsabilController,
                          decoration: _buildInputDecoration(
                              'Responsabil', Icons.person),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
                          controller: _valoareAchizitieController,
                          decoration: _buildInputDecoration(
                              'Valoare Achiziție', Icons.money),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        monedaProvider.hasData
                            ? CustomDropdown(
                                selectedValue: monedaSelectedValue,
                                items: monedaProvider.modedaList
                                    .map((e) => e.modeda)
                                    .toList()
                                    .toSet()
                                    .toList(),
                                textEditingController: TextEditingController(),
                                onAddNewItemPressed: () {},
                                hint: 'Moneda',
                                hintIcon: Icons.attach_money,
                                onChanged: (value) {
                                  setState(() {
                                    monedaSelectedValue = value;
                                  });
                                })
                            : staticVar.loading(),
                        SizedBox(height: 30),
                        isLoading
                            ? CircularProgressIndicator()
                            : CustomButtons(
                                label: 'Adaugă Mașină',
                                onPressed: _submitForm,
                              ),
                      ],
                    ),
                  )
                : staticVar.loading(),
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
