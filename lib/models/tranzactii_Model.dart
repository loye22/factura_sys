import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TranzactiiModel {
  final String idLink;
  final DateTime dataTranzactie;
  final String idTranzactie;
  final String metodaTranzactie;
  final String tipTranzactie;
  final String ibanTitular;
  final String numeTitular;
  final String bancaTitular;
  final String cuiTitular;
  final String ibanPlatitor;
  final String numePlatitor;
  final String bancaPlatitor;
  final String cuiPlatitor;
  final String ibanDestinatar;
  final String numeDestinatar;
  final String bancaDestinatar;
  final String cuiDestinatar;
  final String motivTranzactie;
  final String descriereTranzactie;
  final String referinta;
  final String numarIdentificare;
  final String moneda;
  final double sumaTranzactie;
  final double debit;
  final double credit;
  final String enumFacturi;
  final double soldInitial;
  final double soldFinal;

  TranzactiiModel({
    required this.idLink,
    required this.dataTranzactie,
    required this.idTranzactie,
    required this.metodaTranzactie,
    required this.tipTranzactie,
    required this.ibanTitular,
    required this.numeTitular,
    required this.bancaTitular,
    required this.cuiTitular,
    required this.ibanPlatitor,
    required this.numePlatitor,
    required this.bancaPlatitor,
    required this.cuiPlatitor,
    required this.ibanDestinatar,
    required this.numeDestinatar,
    required this.bancaDestinatar,
    required this.cuiDestinatar,
    required this.motivTranzactie,
    required this.descriereTranzactie,
    required this.referinta,
    required this.numarIdentificare,
    required this.moneda,
    required this.sumaTranzactie,
    required this.debit,
    required this.credit,
    required this.enumFacturi,
    required this.soldInitial,
    required this.soldFinal,
  });
}

class TranzactiiDataSource extends DataGridSource {
  TranzactiiDataSource({required List<TranzactiiModel> tranzactii}) {
    _getTranzactiiData = tranzactii
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'idLink', value: e.idLink),
      DataGridCell<DateTime>(columnName: 'dataTranzactie', value: e.dataTranzactie),
      DataGridCell<String>(columnName: 'idTranzactie', value: e.idTranzactie),
      DataGridCell<String>(columnName: 'metodaTranzactie', value: e.metodaTranzactie),
      DataGridCell<String>(columnName: 'tipTranzactie', value: e.tipTranzactie),
      DataGridCell<String>(columnName: 'ibanTitular', value: e.ibanTitular),
      DataGridCell<String>(columnName: 'numeTitular', value: e.numeTitular),
      DataGridCell<String>(columnName: 'bancaTitular', value: e.bancaTitular),
      DataGridCell<String>(columnName: 'cuiTitular', value: e.cuiTitular),
      DataGridCell<String>(columnName: 'ibanPlatitor', value: e.ibanPlatitor),
      DataGridCell<String>(columnName: 'numePlatitor', value: e.numePlatitor),
      DataGridCell<String>(columnName: 'bancaPlatitor', value: e.bancaPlatitor),
      DataGridCell<String>(columnName: 'cuiPlatitor', value: e.cuiPlatitor),
      DataGridCell<String>(columnName: 'ibanDestinatar', value: e.ibanDestinatar),
      DataGridCell<String>(columnName: 'numeDestinatar', value: e.numeDestinatar),
      DataGridCell<String>(columnName: 'bancaDestinatar', value: e.bancaDestinatar),
      DataGridCell<String>(columnName: 'cuiDestinatar', value: e.cuiDestinatar),
      DataGridCell<String>(columnName: 'motivTranzactie', value: e.motivTranzactie),
      DataGridCell<String>(columnName: 'descriereTranzactie', value: e.descriereTranzactie),
      DataGridCell<String>(columnName: 'referinta', value: e.referinta),
      DataGridCell<String>(columnName: 'numarIdentificare', value: e.numarIdentificare),
      DataGridCell<String>(columnName: 'moneda', value: e.moneda),
      DataGridCell<double>(columnName: 'sumaTranzactie', value: e.sumaTranzactie),
      DataGridCell<double>(columnName: 'debit', value: e.debit),
      DataGridCell<double>(columnName: 'credit', value: e.credit),
      DataGridCell<String>(columnName: 'enumFacturi', value: e.enumFacturi),
      DataGridCell<double>(columnName: 'soldInitial', value: e.soldInitial),
      DataGridCell<double>(columnName: 'soldFinal', value: e.soldFinal),
    ]))
        .toList();
  }

  List<DataGridRow> _getTranzactiiData = [];

  @override
  List<DataGridRow> get rows => _getTranzactiiData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 16.0),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
