import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class firmGestiune_Model {
  final String cuiFirmaGestiune;
  final String denumireFirma;
  final String certificatPDF;
  final String administrator;

  firmGestiune_Model({
    required this.cuiFirmaGestiune,
    required this.denumireFirma,
    required this.certificatPDF,
    required this.administrator,
  });
}

class firmGestiuneDataSource extends DataGridSource {
  firmGestiuneDataSource({required List<firmGestiune_Model> firms}) {
    _getFirmData = firms
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'cuiFirmaGestiune',
        value: e.cuiFirmaGestiune,
      ),
      DataGridCell<String>(
        columnName: 'denumireFirma',
        value: e.denumireFirma,
      ),
      DataGridCell<String>(
        columnName: 'certificatPDF',
        value: e.certificatPDF,
      ),
      DataGridCell<String>(
        columnName: 'administrator',
        value: e.administrator,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getFirmData = [];

  @override
  List<DataGridRow> get rows => _getFirmData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
