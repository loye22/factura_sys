import 'package:factura_sys/models/Facturi_Model.dart';
import 'package:factura_sys/models/staticVar.dart';
import 'package:factura_sys/provider/facturaProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class cautaFacturi extends StatefulWidget {
  const cautaFacturi({super.key});

  @override
  State<cautaFacturi> createState() => _cautaFacturiState();
}

class _cautaFacturiState extends State<cautaFacturi> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    final facturaProviderVar = Provider.of<FacturaProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă factură',
        backgroundColor:  staticVar.themeColor,
        onPressed: () async {
          //showFacturaDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: !facturaProviderVar.hasData
          ? staticVar.loading()
          : SfDataGrid(
        controller: _dataGridController,
        allowSorting: true,
        allowFiltering: true,
        columnWidthMode: ColumnWidthMode.auto,
        source: facturaProviderVar.facturaDataSources, // Updated to FacturaDataSource
        columns: <GridColumn>[
          GridColumn(
            columnName: 'idLink',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Link'),
            ),
          ),
          GridColumn(
            columnName: 'cuiFirmaGestiune',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Firma Gestiune'),
            ),
          ),
          GridColumn(
            columnName: 'denumireFirmaGestiune',
            label: Container(
              alignment: Alignment.center,
              child: Text('Denumire Firma Gestiune'),
            ),
          ),
          GridColumn(
            columnName: 'idRelatieComerciala',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Relatie Comerciala'),
            ),
          ),
          GridColumn(
            columnName: 'idContract',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Contract'),
            ),
          ),
          GridColumn(
            columnName: 'idAnexa',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Anexa'),
            ),
          ),
          GridColumn(
            columnName: 'idFactura',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Factura'),
            ),
          ),
          GridColumn(
            columnName: 'fisierFactura',
            label: Container(
              alignment: Alignment.center,
              child: Text('Fisier Factura'),
            ),
          ),
          GridColumn(
            columnName: 'fisiereAnexe',
            label: Container(
              alignment: Alignment.center,
              child: Text('Fisiere Anexe'),
            ),
          ),
          GridColumn(
            columnName: 'tipFactura',
            label: Container(
              alignment: Alignment.center,
              child: Text('Tip Factura'),
            ),
          ),
          GridColumn(
            columnName: 'statusFactura',
            label: Container(
              alignment: Alignment.center,
              child: Text('Status Factura'),
            ),
          ),
          GridColumn(
            columnName: 'planificat',
            label: Container(
              alignment: Alignment.center,
              child: Text('Planificat?'),
            ),
          ),
          GridColumn(
            columnName: 'cuiFurnizor',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Furnizor'),
            ),
          ),
          GridColumn(
            columnName: 'numeFurnizor',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Furnizor'),
            ),
          ),
          GridColumn(
            columnName: 'ibanFurnizor',
            label: Container(
              alignment: Alignment.center,
              child: Text('IBAN Furnizor'),
            ),
          ),
          GridColumn(
            columnName: 'bancaFurnizor',
            label: Container(
              alignment: Alignment.center,
              child: Text('Banca Furnizor'),
            ),
          ),
          GridColumn(
            columnName: 'cuiBeneficiar',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Beneficiar'),
            ),
          ),
          GridColumn(
            columnName: 'numeBeneficiar',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Beneficiar'),
            ),
          ),
          GridColumn(
            columnName: 'ibanBeneficiar',
            label: Container(
              alignment: Alignment.center,
              child: Text('IBAN Beneficiar'),
            ),
          ),
          GridColumn(
            columnName: 'bancaBeneficiar',
            label: Container(
              alignment: Alignment.center,
              child: Text('Banca Beneficiar'),
            ),
          ),
          GridColumn(
            columnName: 'cuiPlatitor',
            label: Container(
              alignment: Alignment.center,
              child: Text('CUI Platitor'),
            ),
          ),
          GridColumn(
            columnName: 'numePlatitor',
            label: Container(
              alignment: Alignment.center,
              child: Text('Nume Platitor'),
            ),
          ),
          GridColumn(
            columnName: 'ibanPlatitor',
            label: Container(
              alignment: Alignment.center,
              child: Text('IBAN Platitor'),
            ),
          ),
          GridColumn(
            columnName: 'bancaPlatitor',
            label: Container(
              alignment: Alignment.center,
              child: Text('Banca Platitor'),
            ),
          ),
          GridColumn(
            columnName: 'serie',
            label: Container(
              alignment: Alignment.center,
              child: Text('Serie'),
            ),
          ),
          GridColumn(
            columnName: 'numar',
            label: Container(
              alignment: Alignment.center,
              child: Text('Numar'),
            ),
          ),
          GridColumn(
            columnName: 'dataEmitere',
            label: Container(
              alignment: Alignment.center,
              child: Text('Data Emitere'),
            ),
          ),
          GridColumn(
            columnName: 'dataScadenta',
            label: Container(
              alignment: Alignment.center,
              child: Text('Data Scadenta'),
            ),
          ),
          GridColumn(
            columnName: 'punctDeConsum',
            label: Container(
              alignment: Alignment.center,
              child: Text('Punct de Consum'),
            ),
          ),
          GridColumn(
            columnName: 'descriere',
            label: Container(
              alignment: Alignment.center,
              child: Text('Descriere'),
            ),
          ),
          GridColumn(
            columnName: 'moneda',
            label: Container(
              alignment: Alignment.center,
              child: Text('Moneda'),
            ),
          ),
          GridColumn(
            columnName: 'subtotal',
            label: Container(
              alignment: Alignment.center,
              child: Text('Subtotal'),
            ),
          ),
          GridColumn(
            columnName: 'procentTaxe',
            label: Container(
              alignment: Alignment.center,
              child: Text('Procent Taxe'),
            ),
          ),
          GridColumn(
            columnName: 'valoareTaxe',
            label: Container(
              alignment: Alignment.center,
              child: Text('Valoare Taxe'),
            ),
          ),
          GridColumn(
            columnName: 'valoareTotala',
            label: Container(
              alignment: Alignment.center,
              child: Text('Valoare Totala'),
            ),
          ),
          GridColumn(
            columnName: 'retineriTaxe',
            label: Container(
              alignment: Alignment.center,
              child: Text('Retineri Taxe?'),
            ),
          ),
          GridColumn(
            columnName: 'totalDePlata',
            label: Container(
              alignment: Alignment.center,
              child: Text('Total de Plata'),
            ),
          ),
          GridColumn(
            columnName: 'metodaDePlata',
            label: Container(
              alignment: Alignment.center,
              child: Text('Metoda de Plata'),
            ),
          ),
          GridColumn(
            columnName: 'procentDeducereTVA',
            label: Container(
              alignment: Alignment.center,
              child: Text('Procent Deducere TVA'),
            ),
          ),
          GridColumn(
            columnName: 'valoareDeducereTVA',
            label: Container(
              alignment: Alignment.center,
              child: Text('Valoare Deducere TVA'),
            ),
          ),
          GridColumn(
            columnName: 'tipSold',
            label: Container(
              alignment: Alignment.center,
              child: Text('Tip Sold'),
            ),
          ),
          GridColumn(
            columnName: 'sold',
            label: Container(
              alignment: Alignment.center,
              child: Text('Sold'),
            ),
          ),
          GridColumn(
            columnName: 'credit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Credit'),
            ),
          ),
          GridColumn(
            columnName: 'debit',
            label: Container(
              alignment: Alignment.center,
              child: Text('Debit'),
            ),
          ),
          GridColumn(
            columnName: 'enumIdArticoleFacturi',
            label: Container(
              alignment: Alignment.center,
              child: Text('ID Articole Facturi'),
            ),
          ),
          GridColumn(
            columnName: 'subtotalArticole',
            label: Container(
              alignment: Alignment.center,
              child: Text('Subtotal Articole'),
            ),
          ),
          GridColumn(
            columnName: 'valoareTotalaArticole',
            label: Container(
              alignment: Alignment.center,
              child: Text('Valoare Totala Articole'),
            ),
          ),
          GridColumn(
            columnName: 'totalValoareTaxeArticole',
            label: Container(
              alignment: Alignment.center,
              child: Text('Total Valoare Taxe Articole'),
            ),
          ),
          GridColumn(
            columnName: 'areArticoleInSistem',
            label: Container(
              alignment: Alignment.center,
              child: Text('Are Articole in Sistem?'),
            ),
          ),
          GridColumn(
            columnName: 'valoareArticoleSistemEqualsFactura',
            label: Container(
              alignment: Alignment.center,
              child: Text('Valoare Articole Sistem = Factura'),
            ),
          ),
        ],
      )

    );
  }
}
