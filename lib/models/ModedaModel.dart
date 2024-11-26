import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// Refactored Model class for Modeda
class ModedaModel {
  final String modeda;

  ModedaModel({
    required this.modeda,
  });
}

// Refactored DataGridSource class for Modeda
class ModedaDataSource extends DataGridSource {
  ModedaDataSource({required List<ModedaModel> modedas}) {
    _getModedaData = modedas
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'Modeda',
        value: e.modeda,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getModedaData = [];

  @override
  List<DataGridRow> get rows => _getModedaData;

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
