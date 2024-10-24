import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Taxes_Model {
  final String procentTaxa;
  final String tip;
  final String denumire;

  Taxes_Model({
    required this.procentTaxa,
    required this.tip,
    required this.denumire,
  });
}

class TaxesDataSource extends DataGridSource {
  TaxesDataSource({required List<Taxes_Model> taxes}) {
    _getTaxesData = taxes
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'procentTaxa',
        value: e.procentTaxa,
      ),
      DataGridCell<String>(
        columnName: 'tip',
        value: e.tip,
      ),
      DataGridCell<String>(
        columnName: 'denumire',
        value: e.denumire,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getTaxesData = [];

  @override
  List<DataGridRow> get rows => _getTaxesData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(dataGridCell.value.toString()));
        }).toList());
  }
}
