import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class categorie_Model {
  final String categorieTag;

  categorie_Model({
    required this.categorieTag,
  });
}

class categorieDataSource extends DataGridSource {
  categorieDataSource({required List<categorie_Model> categories}) {
    _getCategorieData = categories
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'categorieTag',
        value: e.categorieTag,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getCategorieData = [];

  @override
  List<DataGridRow> get rows => _getCategorieData;

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
