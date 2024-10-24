import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// Define the Concedii model
class concedii_Model {
  final String idConcediu;
  final String idAngajat;
  final String numeAngajat;
  final String cuiAngajator;
  final String denumireFirma;
  final String tip;
  final String dataDeLa;
  final String dataPanaLa;
  final int numarZile;
  final bool aprobat;
  final String perioada;

  concedii_Model({
    required this.idConcediu,
    required this.idAngajat,
    required this.numeAngajat,
    required this.cuiAngajator,
    required this.denumireFirma,
    required this.tip,
    required this.dataDeLa,
    required this.dataPanaLa,
    required this.numarZile,
    required this.aprobat,
    required this.perioada,
  });
}

// Create a data source for Concedii
class concediiDataSource extends DataGridSource {
  concediiDataSource({required List<concedii_Model> concedii}) {
    _getConcediiData = concedii
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'ID Concediu',
        value: e.idConcediu,
      ),
      DataGridCell<String>(
        columnName: 'ID Angajat',
        value: e.idAngajat,
      ),
      DataGridCell<String>(
        columnName: 'Nume Angajat',
        value: e.numeAngajat,
      ),
      DataGridCell<String>(
        columnName: 'CUI Angajator',
        value: e.cuiAngajator,
      ),
      DataGridCell<String>(
        columnName: 'Denumire Firma',
        value: e.denumireFirma,
      ),
      DataGridCell<String>(
        columnName: 'Tip',
        value: e.tip,
      ),
      DataGridCell<String>(
        columnName: 'Data De la',
        value: e.dataDeLa,
      ),
      DataGridCell<String>(
        columnName: 'Data Pana la',
        value: e.dataPanaLa,
      ),
      DataGridCell<int>(
        columnName: 'Numar Zile',
        value: e.numarZile,
      ),
      DataGridCell<bool>(
        columnName: 'Aprobat',
        value: e.aprobat,
      ),
      DataGridCell<String>(
        columnName: 'Perioada',
        value: e.perioada,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getConcediiData = [];

  @override
  List<DataGridRow> get rows => _getConcediiData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 16.0),
          child: dataGridCell.columnName == 'options'
              ? Center(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
          )
              : Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
