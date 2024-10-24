import 'package:factura_sys/models/staticVar.dart';
import 'package:factura_sys/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:factura_sys/provider/taguriProvider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class taguri extends StatefulWidget {
  const taguri({super.key});

  @override
  State<taguri> createState() => _taguriState();
}

class _taguriState extends State<taguri> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    final taguriProviderVar = Provider.of<TaguriProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tag',
        backgroundColor: Color(0xFF3776B6),
        onPressed: () async {
          showTagDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: !taguriProviderVar.hasData
          ? staticVar.loading()
          : SfDataGrid(
        controller: _dataGridController,
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        source: taguriProviderVar.taguriDataSource,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'tag',
            label: Container(
              alignment: Alignment.center,
              child: Text('Tag'),
            ),
          ),
        ],
      ),
    );
  }
}

class TagDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adaugă Tag"),
      content: TagForm(),
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

class TagForm extends StatefulWidget {
  @override
  State<TagForm> createState() => _TagFormState();
}

class _TagFormState extends State<TagForm> {
  final _formKey = GlobalKey<FormState>();
  final _tagNameController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final tag = _tagNameController.text.trim();

      Map<String, dynamic> data = {
        'tag': tag,
      };

      // Call the provider function to add the tag
      await Provider.of<TaguriProvider>(context, listen: false)
          .addTag(context: context, data: data);

      Navigator.of(context).pop(); // Close the dialog after submission
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelStyle: TextStyle(color: Color(0xFF444444)),
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      errorStyle: TextStyle(color: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Set the width as needed
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              TextFormField(
                maxLength: 30,
                controller: _tagNameController,
                decoration: _buildInputDecoration('Tag', Icons.label),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduceți Tag';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtons(
                label: 'Adaugă Tag',
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to show the dialog for adding a tag
void showTagDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Adaugă Tag"),
        content: TagForm(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Anulează"),
          ),
        ],
      );
    },
  );
}
