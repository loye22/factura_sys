import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class iban_Model {
  final String iban;
  final String banca;
  final String cuiTitular;
  final String denumireTitular;
  final String moneda;
  final bool contPropriu;
  final double soldInitial;
  final double soldCurent;

  final DateTime? dataPrimaTranzactieExtras;
  final DateTime? dataUltimaTranzactie;

  final String docId;

  final String userEmail;

  final DateTime timestamp;

  iban_Model(
      {required this.iban,
      required this.banca,
      required this.cuiTitular,
      required this.denumireTitular,
      required this.moneda,
      required this.contPropriu,
      required this.soldInitial,
      required this.soldCurent,
      required this.dataPrimaTranzactieExtras,
      required this.dataUltimaTranzactie,
      required this.docId,
      required this.timestamp,
      required this.userEmail});
}

class ibanDataSource extends DataGridSource {
  ibanDataSource({required List<iban_Model> ibans}) {
    _getIbanData = ibans
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'iban',
                value: e.iban,
              ),
              DataGridCell<String>(
                columnName: 'banca',
                value: e.banca,
              ),
              DataGridCell<String>(
                columnName: 'cuiTitular',
                value: e.cuiTitular,
              ),
              DataGridCell<String>(
                columnName: 'denumireTitular',
                value: e.denumireTitular,
              ),
              DataGridCell<String>(
                columnName: 'moneda',
                value: e.moneda,
              ),
              DataGridCell<bool>(
                columnName: 'contPropriu',
                value: e.contPropriu,
              ),
              DataGridCell<double>(
                columnName: 'soldInitial',
                value: e.soldInitial,
              ),
              DataGridCell<double>(
                columnName: 'soldCurent',
                value: e.soldCurent,
              ),
              DataGridCell<DateTime>(
                columnName: 'dataPrimaTranzactieExtras',
                value: e.dataPrimaTranzactieExtras,
              ),
              DataGridCell<DateTime>(
                columnName: 'dataUltimaTranzactie',
                value: e.dataUltimaTranzactie,
              ),



            ]))
        .toList();
  }

  List<DataGridRow> _getIbanData = [];

  @override
  List<DataGridRow> get rows => _getIbanData;

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
                ))
              : Text(dataGridCell.value.toString()));
    }).toList());
  }
}
