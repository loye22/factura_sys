import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class Taguri_Model {
  final String tag;

  Taguri_Model({
    required this.tag,
  });
}

class TaguriDataSource extends DataGridSource {
  TaguriDataSource({required List<Taguri_Model> tags}) {
    _getTagData = tags
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'tag',
        value: e.tag,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getTagData = [];

  @override
  List<DataGridRow> get rows => _getTagData;

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
