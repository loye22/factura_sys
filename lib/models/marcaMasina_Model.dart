
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class marcaMasina_Model {
  final String marcaMasina;

  marcaMasina_Model({
    required this.marcaMasina,
  });
}

class marcaMasinaDataSource extends DataGridSource {
  marcaMasinaDataSource({required List<marcaMasina_Model> marca}) {
    _getMarcaMasinaData = marca
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'Marca Masina',
        value: e.marcaMasina,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getMarcaMasinaData = [];

  @override
  List<DataGridRow> get rows => _getMarcaMasinaData;

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
