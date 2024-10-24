import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class polite_Model {
  final String idPolitaAsigurari;
  final String tipPolita;
  final String serieSasiu;
  final String numarInmatriculare;
  final String marca;
  final String model;
  final String cuiFurnizor;
  final String numeFurnizor;
  final String valabilitateDeLa;
  final String valabilitatePanaLa;
  final String idFactura;
  final double totalPlata;
  final String statusPlata;
  final String fisierPolita;

  polite_Model({
    required this.idPolitaAsigurari,
    required this.tipPolita,
    required this.serieSasiu,
    required this.numarInmatriculare,
    required this.marca,
    required this.model,
    required this.cuiFurnizor,
    required this.numeFurnizor,
    required this.valabilitateDeLa,
    required this.valabilitatePanaLa,
    required this.idFactura,
    required this.totalPlata,
    required this.statusPlata,
    required this.fisierPolita,
  });
}

class politeDataSource extends DataGridSource {
  politeDataSource({required List<polite_Model> polites}) {
    _getPoliteData = polites
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'idPolitaAsigurari',
        value: e.idPolitaAsigurari,
      ),
      DataGridCell<String>(
        columnName: 'tipPolita',
        value: e.tipPolita,
      ),
      DataGridCell<String>(
        columnName: 'serieSasiu',
        value: e.serieSasiu,
      ),
      DataGridCell<String>(
        columnName: 'numarInmatriculare',
        value: e.numarInmatriculare,
      ),
      DataGridCell<String>(
        columnName: 'marca',
        value: e.marca,
      ),
      DataGridCell<String>(
        columnName: 'model',
        value: e.model,
      ),
      DataGridCell<String>(
        columnName: 'cuiFurnizor',
        value: e.cuiFurnizor,
      ),
      DataGridCell<String>(
        columnName: 'numeFurnizor',
        value: e.numeFurnizor,
      ),
      DataGridCell<String>(
        columnName: 'valabilitateDeLa',
        value: e.valabilitateDeLa,
      ),
      DataGridCell<String>(
        columnName: 'valabilitatePanaLa',
        value: e.valabilitatePanaLa,
      ),
      DataGridCell<String>(
        columnName: 'idFactura',
        value: e.idFactura,
      ),
      DataGridCell<double>(
        columnName: 'totalPlata',
        value: e.totalPlata,
      ),
      DataGridCell<String>(
        columnName: 'statusPlata',
        value: e.statusPlata,
      ),
      DataGridCell<String>(
        columnName: 'fisierPolita',
        value: e.fisierPolita,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getPoliteData = [];

  @override
  List<DataGridRow> get rows => _getPoliteData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16.0),
              child: dataGridCell.columnName == 'options'
                  ? Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  ))
                  : Text(dataGridCell.value.toString()));
        }).toList());
  }
}
