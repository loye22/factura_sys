import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// Refactored Model class for Tipuri
class TipuriModel {
  final String tip;
  final String univers;

  TipuriModel({
    required this.tip,
    required this.univers,
  });
}

// Refactored DataGridSource class for Tipuri
class TipuriDataSource extends DataGridSource {
  TipuriDataSource({required List<TipuriModel> tipuri}) {
    _getTipuriData = tipuri
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'Tip',
        value: e.tip,
      ),
      DataGridCell<String>(
        columnName: 'Univers',
        value: e.univers,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getTipuriData = [];

  @override
  List<DataGridRow> get rows => _getTipuriData;

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
