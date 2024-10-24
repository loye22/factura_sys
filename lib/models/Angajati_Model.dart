import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Angajati_Model {
  final String idAngajat;
  final String cuiAngajator;
  final String numeAngajator;
  final String numePrenume;
  final String functia;
  final String nrContract;
  final String dataContract;
  final String ore;
  final String salariuBrut;
  final String zileConcediuNeefectuate;
  final String zileConcediuEfectuate;
  final String concediiNeefectuatePanaLa20181231;
  final String concediiNeefectuate20191231;
  final String concediiNeefectuate20201231;
  final String concediiNeefectuate20211231;
  final String concediiNeefectuate20221231;
  final String concediiNeefectuate20231231;
  final String concediiNeefectuate20241231;
  final String totalNeefectuate;
  final String fisierCIM;
  final String tipPlata;
  final String descriereJob;
  final String responsabilitati;
  final String beneficii;
  final String cnp;
  final String zileConcediuInUrma;
  final String inputNeefectuate2024;

  Angajati_Model({
    required this.idAngajat,
    required this.cuiAngajator,
    required this.numeAngajator,
    required this.numePrenume,
    required this.functia,
    required this.nrContract,
    required this.dataContract,
    required this.ore,
    required this.salariuBrut,
    required this.zileConcediuNeefectuate,
    required this.zileConcediuEfectuate,
    required this.concediiNeefectuatePanaLa20181231,
    required this.concediiNeefectuate20191231,
    required this.concediiNeefectuate20201231,
    required this.concediiNeefectuate20211231,
    required this.concediiNeefectuate20221231,
    required this.concediiNeefectuate20231231,
    required this.concediiNeefectuate20241231,
    required this.totalNeefectuate,
    required this.fisierCIM,
    required this.tipPlata,
    required this.descriereJob,
    required this.responsabilitati,
    required this.beneficii,
    required this.cnp,
    required this.zileConcediuInUrma,
    required this.inputNeefectuate2024,
  });
}

class AngajatiDataSource extends DataGridSource {
  AngajatiDataSource({required List<Angajati_Model> angajatiList}) {
    _getAngajatiData = angajatiList
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'ID Angajat', value: e.idAngajat),
      DataGridCell<String>(columnName: 'CUI Angajator', value: e.cuiAngajator),
      DataGridCell<String>(columnName: 'Nume Angajator', value: e.numeAngajator),
      DataGridCell<String>(columnName: 'Nume Prenume', value: e.numePrenume),
      DataGridCell<String>(columnName: 'Functia', value: e.functia),
      DataGridCell<String>(columnName: 'Nr Contract', value: e.nrContract),
      DataGridCell<String>(columnName: 'Data Contract', value: e.dataContract),
      DataGridCell<String>(columnName: 'Ore', value: e.ore),
      DataGridCell<String>(columnName: 'Salariu Brut', value: e.salariuBrut),
      DataGridCell<String>(columnName: 'Zile Concediu Neefectuate', value: e.zileConcediuNeefectuate),
      DataGridCell<String>(columnName: 'Zile Concediu Efectuate', value: e.zileConcediuEfectuate),
      DataGridCell<String>(columnName: 'Concedii neefectuate pana la 2018-12-31', value: e.concediiNeefectuatePanaLa20181231),
      DataGridCell<String>(columnName: 'Concedii neefectuate 2019-12-31', value: e.concediiNeefectuate20191231),
      DataGridCell<String>(columnName: 'Concedii neefectuate 2020-12-31', value: e.concediiNeefectuate20201231),
      DataGridCell<String>(columnName: 'Concedii neefectuate 2021-12-31', value: e.concediiNeefectuate20211231),
      DataGridCell<String>(columnName: 'Concedii neefectuate 2022-12-31', value: e.concediiNeefectuate20221231),
      DataGridCell<String>(columnName: 'Concedii neefectuate 2023-12-31', value: e.concediiNeefectuate20231231),
      DataGridCell<String>(columnName: 'Concedii neefectuate 2024-12-31', value: e.concediiNeefectuate20241231),
      DataGridCell<String>(columnName: 'Total Neefectuate', value: e.totalNeefectuate),
      DataGridCell<String>(columnName: 'Fisier CIM', value: e.fisierCIM),
      DataGridCell<String>(columnName: 'Tip Plata', value: e.tipPlata),
      DataGridCell<String>(columnName: 'Descriere Job', value: e.descriereJob),
      DataGridCell<String>(columnName: 'Responsabilitati', value: e.responsabilitati),
      DataGridCell<String>(columnName: 'Beneficii', value: e.beneficii),
      DataGridCell<String>(columnName: 'CNP', value: e.cnp),
      DataGridCell<String>(columnName: 'Zile concediu in urma', value: e.zileConcediuInUrma),
      DataGridCell<String>(columnName: 'Input Neefectuate 2024', value: e.inputNeefectuate2024),
    ]))
        .toList();
  }

  List<DataGridRow> _getAngajatiData = [];

  @override
  List<DataGridRow> get rows => _getAngajatiData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }
}
