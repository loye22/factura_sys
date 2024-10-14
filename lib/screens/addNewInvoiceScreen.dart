import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addNewInvoiceScreen extends StatefulWidget {
  const addNewInvoiceScreen({super.key});

  @override
  State<addNewInvoiceScreen> createState() => _addNewInvoiceScreenState();
}

class _addNewInvoiceScreenState extends State<addNewInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Container( child: Center(child: Text("Add new invoice page ")),);
  }
}
