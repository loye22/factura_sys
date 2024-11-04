import 'package:factura_sys/models/staticVar.dart';
import 'package:factura_sys/provider/entitatiProvider.dart';
import 'package:factura_sys/provider/marcaMasinaProvider.dart';
import 'package:factura_sys/widgets/CustomDropdown.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class gestiuneMasiniDrawer extends StatefulWidget {
  @override
  _gestiuneMasiniDrawerState createState() => _gestiuneMasiniDrawerState();
}

class _gestiuneMasiniDrawerState extends State<gestiuneMasiniDrawer> {
  // Controllers for text fields to capture user input
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
  String? comodataSelectedValue;
  String? MarcaMasinaSelectedValue;

  @override
  Widget build(BuildContext context) {
    final entitatiProvider = Provider.of<EntitatiProvider>(context);
    final MarcaProvider = Provider.of<MarcaMasinaProvider>(context);
    return Drawer(
      width: 800,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                TextFormField(
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
                        hintIcon: Icons.handshake,
                        onChanged: (value) {
                          setState(() {
                            comodataSelectedValue = value;
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
                MarcaProvider.hasData
                    ? CustomDropdown(
                        selectedValue: MarcaMasinaSelectedValue,
                        items: MarcaProvider.marcaMasinaList
                            .map((e) => e.marcaMasina)
                            .toList()
                            .toSet()
                            .toList(),
                        textEditingController: _marcaMasinaController,
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
                TextFormField(
                  controller: _modelController,
                  decoration:
                      _buildInputDecoration('Model', Icons.model_training),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _anulController,
                  decoration:
                      _buildInputDecoration('Anul', Icons.calendar_today),
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
                  decoration:
                      _buildInputDecoration('Responsabil', Icons.person),
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
                  decoration:
                      _buildInputDecoration('Moneda', Icons.attach_money),
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
      ),
    );
  }
}
