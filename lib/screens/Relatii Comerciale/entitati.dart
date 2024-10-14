import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factura_sys/models/entitati_Model.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/staticVar.dart';

class entitati extends StatefulWidget {
  const entitati({super.key});

  @override
  State<entitati> createState() => _entitatiState();
}

class _entitatiState extends State<entitati> {
  final DataGridController _dataGridController = DataGridController();
  late entitatiDataSource entitatiDataSources;
  List<entitati_Model> entitatiListTodisplay = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    entitiesFromFirrbase();

    entitatiDataSources = entitatiDataSource(orders: entitatiListTodisplay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă entitate',
        backgroundColor: Color(0xFF3776B6),
        onPressed: () {
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
        columnWidthMode: ColumnWidthMode.none,
        // Disable auto-resizing

        source: entitatiDataSources,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'cuiEntitate',
            width: staticVar.fullWidth(context) *.27, // Set a fixed width
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Entitate'),
            ),
          ),
          GridColumn(
            columnName: 'tip',
            width: 150, // Set a fixed width
            label: Container(
              alignment: Alignment.centerRight,
              child: Text('Tip'),
            ),
          ),
          GridColumn(
            columnName: 'Denumire',
            width: 150, // Set a fixed width
            label: Container(
              alignment: Alignment.centerRight,
              child: Text('Denumire'),
            ),
          ),
          GridColumn(
            columnName: 'userEmail',
            width: 150, // Set a fixed width
            label: Container(
              alignment: Alignment.centerRight,
              child: Text('userEmail'),
            ),
          ),
          GridColumn(
            columnName: 'timestamp',
            width: staticVar.fullWidth(context) *.28, // Set a fixed width
            label: Container(
              alignment: Alignment.center,
              child: Text('AddedAt'),
            ),
          ),
        ],
      )
    );

    //Container( child: Center(child: Text("entitati page ")),);
  }

  // this function gonna fetch all the orders
  Future<void> entitiesFromFirrbase() async {
    // Initialize Firebase
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Define a list to store the fetched data
    List<Map<String, dynamic>> entitesList = [];

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection('entitati')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((querySnapshot) {
        List<entitati_Model> ordersHeper = [];

        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data["docId"] = doc.id;
          entitati_Model entitie = entitati_Model(
            docId: doc.id,
            denumire: data['denumire'] ?? '',
            tip: data['tip'] ?? '',
            cuiEntitate: data['cui'] ?? '',
            timestamp: data['timestamp'].toDate(),
            userEmail: 'userEmail',
          );

          ordersHeper.add(entitie);

        }
        entitatiListTodisplay = ordersHeper;
        entitatiDataSources = entitatiDataSource(orders: entitatiListTodisplay);


        setState(() {});
      });
    } catch (e) {
      // Print any errors for debugging purposes
      print('Error fetching : $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message:
          "Something went wrong. Please check your credentials and try again",
        ),
      );

    }
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
  final _tipController = TextEditingController();
  final _denumireController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        this.isLoading = true;
        setState(() {});

        final String cui = _cuiController.text.trim();
        final String tip = _tipController.text.trim();
        final String denumire = _denumireController.text.trim();
        User? user = FirebaseAuth.instance.currentUser;

        // Prepare the data to be added
        Map<String, dynamic> data = {
          'cui': cui,
          'tip': tip,
          'denumire': denumire,
          'timestamp': DateTime.now(), // Firebase server timestamp
          'userEmail': user!.email, // User's email
        };

        await FirebaseFirestore.instance.collection('entitati').add(data);

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Înregistrarea a fost adăugată cu succes. ",
          ),
        );

        print("CUI: $cui, Tip: $tip, Denumire: $denumire");
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensure the dialog is not too tall
        children: [
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
          TextFormField(
            controller: _tipController,
            decoration: _buildInputDecoration('Tip', Icons.category),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Introduceți Tipul';
              }
              return null;
            },
          ),
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
