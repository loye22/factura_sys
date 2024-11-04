import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class gestinueMasini_Model {
  final String serieSasiu;
  final String cuiProprietar;
  final String proprietar;
  final String comodat;
  final String numarInmatricular;
  final String marcaMasina;
  final String modelModel;
  final String anul; // Changed to int for the year
  final String utilizator;
  final String kilometraj;
  final String tipCombustibil;
  final DateTime valabilitateRCA;
  final DateTime valabilitateITP;
  final DateTime valabilitateROVINIETA;
  final DateTime valabilitateCASCO;
  final String responsabil;
  final String valoareAchizitie;
  final String moneda;
  final String intrariService; // Assuming this is a String
  final String cheltuieliService; // Assuming this is a String

  gestinueMasini_Model({
    required this.serieSasiu,
    required this.cuiProprietar,
    required this.proprietar,
    required this.comodat,
    required this.numarInmatricular,
    required this.marcaMasina,
    required this.modelModel,
    required this.anul,
    required this.utilizator,
    required this.kilometraj,
    required this.tipCombustibil,
    required this.valabilitateRCA,
    required this.valabilitateITP,
    required this.valabilitateROVINIETA,
    required this.valabilitateCASCO,
    required this.responsabil,
    required this.valoareAchizitie,
    required this.moneda,
    required this.intrariService,
    required this.cheltuieliService,
  });
}

class gestinueMasiniDataSource extends DataGridSource {
  gestinueMasiniDataSource({required List<gestinueMasini_Model> masini}) {
    _getMasiniData = masini
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'serieSasiu',
                value: e.serieSasiu,
              ),
              DataGridCell<String>(
                columnName: 'cuiProprietar',
                value: e.cuiProprietar,
              ),
              DataGridCell<String>(
                columnName: 'proprietar',
                value: e.proprietar,
              ),
              DataGridCell<String>(
                columnName: 'comodat',
                value: e.comodat,
              ),
              DataGridCell<String>(
                columnName: 'numarInmatricular',
                value: e.numarInmatricular,
              ),
              DataGridCell<String>(
                columnName: 'marcaMasina',
                value: e.marcaMasina,
              ),
              DataGridCell<String>(
                columnName: 'modelModel',
                value: e.modelModel,
              ),
              DataGridCell<String>(
                columnName: 'anul',
                value: e.anul,
              ),
              DataGridCell<String>(
                columnName: 'utilizator',
                value: e.utilizator,
              ),
              DataGridCell<String>(
                columnName: 'kilometraj',
                value: e.kilometraj,
              ),
              DataGridCell<String>(
                columnName: 'tipCombustibil',
                value: e.tipCombustibil,
              ),
              DataGridCell<DateTime>(
                columnName: 'valabilitateRCA',
                value: e.valabilitateRCA,
              ),
              DataGridCell<DateTime>(
                columnName: 'valabilitateITP',
                value: e.valabilitateITP,
              ),
              DataGridCell<DateTime>(
                columnName: 'valabilitateROVINIETA',
                value: e.valabilitateROVINIETA,
              ),
              DataGridCell<DateTime>(
                columnName: 'valabilitateCASCO',
                value: e.valabilitateCASCO,
              ),
              DataGridCell<String>(
                columnName: 'responsabil',
                value: e.responsabil,
              ),
              DataGridCell<String>(
                columnName: 'valoareAchizitie',
                value: e.valoareAchizitie,
              ),
              DataGridCell<String>(
                columnName: 'moneda',
                value: e.moneda,
              ),
              DataGridCell<String>(
                columnName: 'intrariService',
                value: e.intrariService,
              ),
              DataGridCell<String>(
                columnName: 'cheltuieliService',
                value: e.cheltuieliService,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _getMasiniData = [];

  @override
  List<DataGridRow> get rows => _getMasiniData;

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
