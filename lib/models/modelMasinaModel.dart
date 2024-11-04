import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// Refactored Model class
class modelMasinaModel {
  final String model;
  final String marcaMasina;

  modelMasinaModel({
    required this.model,
    required this.marcaMasina,
  });
}

// Refactored DataGridSource class
class modelMasinaDataSource extends DataGridSource {
  modelMasinaDataSource({required List<modelMasinaModel> masini}) {
    _getMasinaData = masini
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'Model',
        value: e.model,
      ),
      DataGridCell<String>(
        columnName: 'Marca Masina',
        value: e.marcaMasina,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getMasinaData = [];

  @override
  List<DataGridRow> get rows => _getMasinaData;

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
