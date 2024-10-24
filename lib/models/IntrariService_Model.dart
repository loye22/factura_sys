import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

  class IntrariService_Model {
    final String idIntrareService;
    final String serieSasiu;
    final String numarInmatriculare;
    final String marca;
    final String model;
    final String cuiService;
    final String denumireService;
    final String motiv;
    final String dataDeLa;
    final String dataPanaLa;
    final String idFactura;
    final double totalPlata;
    final String statusPlata;
    final String constatare;
    final String fisierDeviz;

    IntrariService_Model({
      required this.idIntrareService,
      required this.serieSasiu,
      required this.numarInmatriculare,
      required this.marca,
      required this.model,
      required this.cuiService,
      required this.denumireService,
      required this.motiv,
      required this.dataDeLa,
      required this.dataPanaLa,
      required this.idFactura,
      required this.totalPlata,
      required this.statusPlata,
      required this.constatare,
      required this.fisierDeviz,
    });
  }

class IntrariServiceDataSource extends DataGridSource {
  IntrariServiceDataSource({required List<IntrariService_Model> intrariServices}) {
    _getIntrariServiceData = intrariServices
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'idIntrareService',
        value: e.idIntrareService,
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
        columnName: 'cuiService',
        value: e.cuiService,
      ),
      DataGridCell<String>(
        columnName: 'denumireService',
        value: e.denumireService,
      ),
      DataGridCell<String>(
        columnName: 'motiv',
        value: e.motiv,
      ),
      DataGridCell<String>(
        columnName: 'dataDeLa',
        value: e.dataDeLa,
      ),
      DataGridCell<String>(
        columnName: 'dataPanaLa',
        value: e.dataPanaLa,
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
        columnName: 'constatare',
        value: e.constatare,
      ),
      DataGridCell<String>(
        columnName: 'fisierDeviz',
        value: e.fisierDeviz,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getIntrariServiceData = [];

  @override
  List<DataGridRow> get rows => _getIntrariServiceData;

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
            ),
          )
              : Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
