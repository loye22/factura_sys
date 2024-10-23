import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class relatii_Model {
  final String idRelatieComerciala;
  final String cuiFirmaGestiune;
  final String denumireFirma;
  final String cuiPartener;
  final String denumirePartener;
  final String idContract;
  final String denumireContract;
  final String descriereContract;
  final DateTime? dataIncepereContract;
  final DateTime? dataIncetareContract; // Nullable in case the contract is still active
  final String clientFurnizor;
  final String categorie;
  final String subcategorie;
  final double totalCredit;
  final double tranzactiiCredit;
  final double medieTranzactiiCredit;
  final double totalDebit;
  final double tranzactiiDebit;
  final double medieTranzactiiDebit;
  final double balanta;
  final String labelRelatieComerciala;

  relatii_Model({
    required this.idRelatieComerciala,
    required this.cuiFirmaGestiune,
    required this.denumireFirma,
    required this.cuiPartener,
    required this.denumirePartener,
    required this.idContract,
    required this.denumireContract,
    required this.descriereContract,
    required this.dataIncepereContract,
    this.dataIncetareContract,
    required this.clientFurnizor,
    required this.categorie,
    required this.subcategorie,
    required this.totalCredit,
    required this.tranzactiiCredit,
    required this.medieTranzactiiCredit,
    required this.totalDebit,
    required this.tranzactiiDebit,
    required this.medieTranzactiiDebit,
    required this.balanta,
    required this.labelRelatieComerciala,
  });
}

class RelatiiDataSource extends DataGridSource {
  RelatiiDataSource({required List<relatii_Model> relatii}) {
    _getRelatiiData = relatii
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'ID Relatie Comerciala',
        value: e.idRelatieComerciala,
      ),
      DataGridCell<String>(
        columnName: 'CUI Firma Gestiune',
        value: e.cuiFirmaGestiune,
      ),
      DataGridCell<String>(
        columnName: 'Denumire Firma',
        value: e.denumireFirma,
      ),
      DataGridCell<String>(
        columnName: 'CUI Partener',
        value: e.cuiPartener,
      ),
      DataGridCell<String>(
        columnName: 'Denumire Partener',
        value: e.denumirePartener,
      ),
      DataGridCell<String>(
        columnName: 'ID Contract',
        value: e.idContract,
      ),
      DataGridCell<String>(
        columnName: 'Denumire Contract',
        value: e.denumireContract,
      ),
      DataGridCell<String>(
        columnName: 'Descriere Contract',
        value: e.descriereContract,
      ),
      DataGridCell<DateTime>(
        columnName: 'Data Incepere Contract',
        value: e.dataIncepereContract,
      ),
      DataGridCell<DateTime?>(
        columnName: 'Data Incetare Contract',
        value: e.dataIncetareContract,
      ),
      DataGridCell<String>(
        columnName: 'Client / Furnizor',
        value: e.clientFurnizor,
      ),
      DataGridCell<String>(
        columnName: 'Categorie',
        value: e.categorie,
      ),
      DataGridCell<String>(
        columnName: 'Subcategorie',
        value: e.subcategorie,
      ),
      DataGridCell<double>(
        columnName: 'Total Credit',
        value: e.totalCredit,
      ),
      DataGridCell<double>(
        columnName: 'Tranzactii Credit',
        value: e.tranzactiiCredit,
      ),
      DataGridCell<double>(
        columnName: 'Medie Tranzactii Credit',
        value: e.medieTranzactiiCredit,
      ),
      DataGridCell<double>(
        columnName: 'Total Debit',
        value: e.totalDebit,
      ),
      DataGridCell<double>(
        columnName: 'Tranzactii Debit',
        value: e.tranzactiiDebit,
      ),
      DataGridCell<double>(
        columnName: 'Medie Tranzactii Debit',
        value: e.medieTranzactiiDebit,
      ),
      DataGridCell<double>(
        columnName: 'Balanta',
        value: e.balanta,
      ),
      DataGridCell<String>(
        columnName: 'Label Relatie Comerciala',
        value: e.labelRelatieComerciala,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getRelatiiData = [];

  @override
  List<DataGridRow> get rows => _getRelatiiData;

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
