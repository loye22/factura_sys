import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:factura_sys/models/entitati_Model.dart';
import 'package:factura_sys/provider/entitatiProvider.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/staticVar.dart';
import '../../widgets/CustomDropdown.dart';

class entitati extends StatefulWidget {
  const entitati({super.key});

  @override
  State<entitati> createState() => _entitatiState();
}

class _entitatiState extends State<entitati> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    final entitatiProvider = Provider.of<EntitatiProvider>(context);
    return !entitatiProvider.hasData ? staticVar.loading() :  Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adaugă entitate',
          backgroundColor: Color(0xFF3776B6),
          onPressed: () async {
            /// await  uploadDataToFirebaseFromJSON("louie@aurorafoods.ro");
            showEntitatiDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SfDataGrid(
          controller: _dataGridController,
          // showCheckboxColumn: true,
          // selectionMode: SelectionMode.multiple,
          allowSorting: true,
          allowFiltering: true,
          columnWidthMode: ColumnWidthMode.fill,

          // columnWidthMode: ColumnWidthMode.,
          // Disable auto-resizing

          source: entitatiProvider.hasData ? entitatiProvider.entitatiDataSources :
              entitatiDataSource(orders: []),
          //entitatiDataSources,
          columns: <GridColumn>[
            GridColumn(
              columnName: 'cuiEntitate',
              label: Container(
                alignment: Alignment.center,
                child: Text('CUI Entitate'),
              ),
            ),
            GridColumn(
              columnName: 'tip',

              ///   width: 150, // Set a fixed width
              label: Container(
                alignment: Alignment.center,
                child: Text('Tip'),
              ),
            ),
            GridColumn(
              columnName: 'Denumire',
              //  width: 150, // Set a fixed width
              label: Container(
                alignment: Alignment.center,
                child: Text('Denumire'),
              ),
            ),
          ],
        ));

    //Container( child: Center(child: Text("entitati page ")),);
  }

  Future<void> uploadDataToFirebaseFromJSON(String userEmail) async {
    int i = 0;
    // Load JSON data from file (assuming your JSON is in assets folder)
    final String response = await rootBundle.loadString('assets/ee.json');
    final List<dynamic> data = json.decode(response); // Decode the JSON file

    // Get Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (var item in data) {
      // Adapt each record to the Firebase structure
      Map<String, dynamic> adaptedRecord = {
        'cui': item['CUI Entitate'],
        'denumire': item['Denumire'],
        'timestamp': DateTime.now(),
        'tip': item['Tip'],
        'userEmail': userEmail,
      };
      i++;

      // Add to Firebase (assuming you have a collection named 'entities')
      await firestore.collection('entitati').add(adaptedRecord);
    }
    print("$i record as been added ");
  }
}

class EntitatiDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("Adaugă Entitate"),
      content: EntitatiForm(),
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

class EntitatiForm extends StatefulWidget {
  @override
  State<EntitatiForm> createState() => _EntitatiFormState();
}

class _EntitatiFormState extends State<EntitatiForm> {
  final _formKey = GlobalKey<FormState>();
  final _cuiController = TextEditingController();
  final _denumireController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        this.isLoading = true;
        setState(() {});

        final String cui = _cuiController.text.trim();
        final String denumire = _denumireController.text.trim();
        User? user = FirebaseAuth.instance.currentUser;

        // Prepare the data to be added
        Map<String, dynamic> data = {
          'cui': cui,
          'tip': selectedValueFromDropDown!.trim(),
          'denumire': denumire,
          'timestamp': DateTime.now(),
          'userEmail': user!.email,
        };

        // Access the provider and call the addEntitate method
        await Provider.of<EntitatiProvider>(context, listen: false)
            .addEntitate(context: context, data: data);

        ///await FirebaseFirestore.instance.collection('entitati').add(data);

        print("CUI: $cui, Tip: $selectedValueFromDropDown, Denumire: $denumire");
        // Handle form submission
        Navigator.of(context).pop(); // Close the dialog after submission
      } else {
        this.isLoading = false;
        setState(() {});
        print("Invalid input");
      }
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message:
              "Something went wrong. Please check your credentials and try again $e",
        ),
      );
      print("error $e");
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

  String? selectedValueFromDropDown;
  final TextEditingController textEditingController = TextEditingController();


  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final entitatiProviderForTips = Provider.of<EntitatiProvider>(context);
    return SizedBox(
      width: staticVar.fullWidth(context) * .3,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Ensure the dialog is not too tall
          children: [
            SizedBox(height: 20), // Space between dropdown and button

            TextFormField(
              controller: _cuiController,
              decoration: _buildInputDecoration('CUI Entitate', Icons.business),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Introduceți CUI Entitate';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomDropdown(
               items:entitatiProviderForTips.tipuriList ,
              selectedValue: selectedValueFromDropDown,
              textEditingController: textEditingController,
              onChanged: (value) {
                setState(() {
                  selectedValueFromDropDown = value;
                });
              },
              onAddNewItemPressed: () {
                print('Add new item pressed');
              },

            ),
            // TextFormField(
            //   controller: _tipController,
            //   decoration: _buildInputDecoration('Tip', Icons.category),
            //   validator: (value) {
            //     if (value == null || value.trim().isEmpty) {
            //       return 'Introduceți Tipul';
            //     }
            //     return null;
            //   },
            // ),
            SizedBox(height: 20),
            TextFormField(
              controller: _denumireController,
              decoration: _buildInputDecoration('Denumire', Icons.text_fields),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Introduceți Denumirea';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            isLoading
                ? CircularProgressIndicator()
                : CustomButtons(
                    label: 'Adaugă entitate',
                    onPressed:
                        _submitForm, // Call submit function on button press
                  ),
          ],
        ),
      ),
    );
  }
}

// Function to show the dialog
void showEntitatiDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return EntitatiDialog();
    },
  );
}
