import 'package:factura_sys/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Factura_Model {
  final String idLink;
  final String cuiFirmaGestiune;
  final String denumireFirmaGestiune;
  final String idRelatieComerciala;
  final String idContract;
  final String idAnexa;
  final String idFactura;
  final String fisierFactura;
  final String fisiereAnexe;
  final String tipFactura;
  final String statusFactura;
  final bool planificat;
  final String cuiFurnizor;
  final String numeFurnizor;
  final String ibanFurnizor;
  final String bancaFurnizor;
  final String cuiBeneficiar;
  final String numeBeneficiar;
  final String ibanBeneficiar;
  final String bancaBeneficiar;
  final String cuiPlatitor;
  final String numePlatitor;
  final String ibanPlatitor;
  final String bancaPlatitor;
  final String serie;
  final String numar;
  final DateTime dataEmitere;
  final DateTime dataScadenta;
  final String punctDeConsum;
  final String descriere;
  final String moneda;
  final double subtotal;
  final double procentTaxe;
  final double valoareTaxe;
  final double valoareTotala;
  final bool retineriTaxe;
  final double totalDePlata;
  final String metodaDePlata;
  final double procentDeducereTVA;
  final double valoareDeducereTVA;
  final String tipSold;
  final double sold;
  final double credit;
  final double debit;
  final String enumIdArticoleFacturi;
  final double subtotalArticole;
  final double valoareTotalaArticole;
  final double totalValoareTaxeArticole;
  final bool areArticoleInSistem;
  final bool valoareArticoleSistemEqualsFactura;
  final bool facturaAChitata;
  final double soldRamasNeachitat;
  final String statusPlata;
  final String enumTranzactii;
  final String fisierNIR;
  final String detaliiExtra;
  final String codClient;
  final String numarSAP;
  final String codPlata;
  final String codDeBare;
  final String numarRata;
  final String categorieTag;
  final String subcategorieTag;
  final String brand;
  final String scop;
  final String tagIndividual;
  final String cuiBeneficiarLabel;
  final String numeBeneficiarLabel;



  Factura_Model({
    required this.idLink,
    required this.cuiFirmaGestiune,
    required this.denumireFirmaGestiune,
    required this.idRelatieComerciala,
    required this.idContract,
    required this.idAnexa,
    required this.idFactura,
    required this.fisierFactura,
    required this.fisiereAnexe,
    required this.tipFactura,
    required this.statusFactura,
    required this.planificat,
    required this.cuiFurnizor,
    required this.numeFurnizor,
    required this.ibanFurnizor,
    required this.bancaFurnizor,
    required this.cuiBeneficiar,
    required this.numeBeneficiar,
    required this.ibanBeneficiar,
    required this.bancaBeneficiar,
    required this.cuiPlatitor,
    required this.numePlatitor,
    required this.ibanPlatitor,
    required this.bancaPlatitor,
    required this.serie,
    required this.numar,
    required this.dataEmitere,
    required this.dataScadenta,
    required this.punctDeConsum,
    required this.descriere,
    required this.moneda,
    required this.subtotal,
    required this.procentTaxe,
    required this.valoareTaxe,
    required this.valoareTotala,
    required this.retineriTaxe,
    required this.totalDePlata,
    required this.metodaDePlata,
    required this.procentDeducereTVA,
    required this.valoareDeducereTVA,
    required this.tipSold,
    required this.sold,
    required this.credit,
    required this.debit,
    required this.enumIdArticoleFacturi,
    required this.subtotalArticole,
    required this.valoareTotalaArticole,
    required this.totalValoareTaxeArticole,
    required this.areArticoleInSistem,
    required this.valoareArticoleSistemEqualsFactura,
    required this.facturaAChitata,
    required this.soldRamasNeachitat,
    required this.statusPlata,
    required this.enumTranzactii,
    required this.fisierNIR,
    required this.detaliiExtra,
    required this.codClient,
    required this.numarSAP,
    required this.codPlata,
    required this.codDeBare,
    required this.numarRata,
    required this.categorieTag,
    required this.subcategorieTag,
    required this.brand,
    required this.scop,
    required this.tagIndividual,
    required this.cuiBeneficiarLabel,
    required this.numeBeneficiarLabel,

  });
}

class FacturaDataSource extends DataGridSource {
  FacturaDataSource({required List<Factura_Model> facturi}) {
    _getFacturaData = facturi.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'idLink', value: e.idLink),
      DataGridCell<String>(columnName: 'cuiFirmaGestiune', value: e.cuiFirmaGestiune),
      DataGridCell<String>(columnName: 'denumireFirmaGestiune', value: e.denumireFirmaGestiune),
      DataGridCell<String>(columnName: 'idRelatieComerciala', value: e.idRelatieComerciala),
      DataGridCell<String>(columnName: 'idContract', value: e.idContract),
      DataGridCell<String>(columnName: 'idAnexa', value: e.idAnexa),
      DataGridCell<String>(columnName: 'idFactura', value: e.idFactura),
      DataGridCell<String>(columnName: 'fisierFactura', value: e.fisierFactura),
      DataGridCell<String>(columnName: 'fisiereAnexe', value: e.fisiereAnexe),
      DataGridCell<String>(columnName: 'tipFactura', value: e.tipFactura),
      DataGridCell<String>(columnName: 'statusFactura', value: e.statusFactura),
      DataGridCell<bool>(columnName: 'planificat', value: e.planificat),
      DataGridCell<String>(columnName: 'cuiFurnizor', value: e.cuiFurnizor),
      DataGridCell<String>(columnName: 'numeFurnizor', value: e.numeFurnizor),
      DataGridCell<String>(columnName: 'ibanFurnizor', value: e.ibanFurnizor),
      DataGridCell<String>(columnName: 'bancaFurnizor', value: e.bancaFurnizor),
      DataGridCell<String>(columnName: 'cuiBeneficiar', value: e.cuiBeneficiar),
      DataGridCell<String>(columnName: 'numeBeneficiar', value: e.numeBeneficiar),
      DataGridCell<String>(columnName: 'ibanBeneficiar', value: e.ibanBeneficiar),
      DataGridCell<String>(columnName: 'bancaBeneficiar', value: e.bancaBeneficiar),
      DataGridCell<String>(columnName: 'cuiPlatitor', value: e.cuiPlatitor),
      DataGridCell<String>(columnName: 'numePlatitor', value: e.numePlatitor),
      DataGridCell<String>(columnName: 'ibanPlatitor', value: e.ibanPlatitor),
      DataGridCell<String>(columnName: 'bancaPlatitor', value: e.bancaPlatitor),
      DataGridCell<String>(columnName: 'serie', value: e.serie),
      DataGridCell<String>(columnName: 'numar', value: e.numar),
      DataGridCell<DateTime>(columnName: 'dataEmitere', value: e.dataEmitere),
      DataGridCell<DateTime>(columnName: 'dataScadenta', value: e.dataScadenta),
      DataGridCell<String>(columnName: 'punctDeConsum', value: e.punctDeConsum),
      DataGridCell<String>(columnName: 'descriere', value: e.descriere),
      DataGridCell<String>(columnName: 'moneda', value: e.moneda),
      DataGridCell<double>(columnName: 'subtotal', value: e.subtotal),
      DataGridCell<double>(columnName: 'procentTaxe', value: e.procentTaxe),
      DataGridCell<double>(columnName: 'valoareTaxe', value: e.valoareTaxe),
      DataGridCell<double>(columnName: 'valoareTotala', value: e.valoareTotala),
      DataGridCell<bool>(columnName: 'retineriTaxe', value: e.retineriTaxe),
      DataGridCell<double>(columnName: 'totalDePlata', value: e.totalDePlata),
      DataGridCell<String>(columnName: 'metodaDePlata', value: e.metodaDePlata),
      DataGridCell<double>(columnName: 'procentDeducereTVA', value: e.procentDeducereTVA),
      DataGridCell<double>(columnName: 'valoareDeducereTVA', value: e.valoareDeducereTVA),
      DataGridCell<String>(columnName: 'tipSold', value: e.tipSold),
      DataGridCell<double>(columnName: 'sold', value: e.sold),
      DataGridCell<double>(columnName: 'credit', value: e.credit),
      DataGridCell<double>(columnName: 'debit', value: e.debit),
      DataGridCell<String>(columnName: 'enumIdArticoleFacturi', value: e.enumIdArticoleFacturi),
      DataGridCell<double>(columnName: 'subtotalArticole', value: e.subtotalArticole),
      DataGridCell<double>(columnName: 'valoareTotalaArticole', value: e.valoareTotalaArticole),
      DataGridCell<double>(columnName: 'totalValoareTaxeArticole', value: e.totalValoareTaxeArticole),
      DataGridCell<bool>(columnName: 'areArticoleInSistem', value: e.areArticoleInSistem),
      DataGridCell<bool>(columnName: 'valoareArticoleSistemEqualsFactura', value: e.valoareArticoleSistemEqualsFactura),
    ])).toList();
  }

  List<DataGridRow> _getFacturaData = [];

  @override
  List<DataGridRow> get rows => _getFacturaData;

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
