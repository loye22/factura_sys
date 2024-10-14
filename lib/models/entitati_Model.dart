import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class entitati_Model {
  final String cuiEntitate;
  final String tip;
  final String denumire;
  final DateTime timestamp;
  final String userEmail;
  final String docId;


  entitati_Model(
      {required this.cuiEntitate,
      required this.tip,
      required this.denumire,
      required this.timestamp,
      required this.userEmail ,
      required this.docId});
}

class entitatiDataSource extends DataGridSource {
  entitatiDataSource({required List<entitati_Model> orders}) {
    _getEntitatiData = orders
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'cuiEntitate',
                value: e.cuiEntitate,
              ),
              DataGridCell<String>(
                columnName: 'tip',
                value: e.tip,
              ),
              DataGridCell<String>(
                columnName: 'Denumire',
                value: e.denumire,
              ),
              DataGridCell<String>(
                columnName: 'userEmail',
                value: e.userEmail,
              ),
              DataGridCell<DateTime>(
                columnName: 'timestamp',
                value: e.timestamp,
              ),

            ]))
        .toList();
  }

  List<DataGridRow> _getEntitatiData = [];

  @override
  List<DataGridRow> get rows => _getEntitatiData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 16.0),
        child: dataGridCell.columnName == 'options'
            ?
        Center(
                child: IconButton(onPressed: (){}, icon : Icon(Icons.delete),)
        )
            :Text(dataGridCell.value.toString())
      );
    }).toList());
  }
}
