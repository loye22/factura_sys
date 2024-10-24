import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class status_Model {
  final String status;
  final String univers;

  status_Model({
    required this.status,
    required this.univers,
  });
}

class statusDataSource extends DataGridSource {
  statusDataSource({required List<status_Model> statuses}) {
    _getStatusData = statuses
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'status',
        value: e.status,
      ),
      DataGridCell<String>(
        columnName: 'univers',
        value: e.univers,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getStatusData = [];

  @override
  List<DataGridRow> get rows => _getStatusData;

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
