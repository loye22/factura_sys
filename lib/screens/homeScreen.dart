import 'package:factura_sys/screens/Angajati/concedii.dart';
import 'package:factura_sys/screens/Angajati/contracteAngajati.dart';
import 'package:factura_sys/screens/Facturi/adaugaFacturi.dart';
import 'package:factura_sys/screens/Facturi/articoleFacturi.dart';
import 'package:factura_sys/screens/Facturi/cautaFacturi.dart';
import 'package:factura_sys/screens/Parc_Auto/consumCarburant.dart';
import 'package:factura_sys/screens/Parc_Auto/gestiuneMasini.dart';
import 'package:factura_sys/screens/Parc_Auto/intrariService.dart';
import 'package:factura_sys/screens/Parc_Auto/polite.dart';
import 'package:factura_sys/screens/Relatii%20Comerciale/entitati.dart';
import 'package:factura_sys/screens/Relatii%20Comerciale/ibanUri.dart';
import 'package:factura_sys/screens/Relatii%20Comerciale/relatii.dart';
import 'package:factura_sys/screens/Setari%20Gestiune/categorii.dart';
import 'package:factura_sys/screens/Setari%20Gestiune/detaliiExtra.dart';
import 'package:factura_sys/screens/Setari%20Gestiune/firmeGestiune.dart';
import 'package:factura_sys/screens/Setari%20Gestiune/statusuri.dart';
import 'package:factura_sys/screens/Setari%20Gestiune/taguri.dart';
import 'package:factura_sys/screens/Setari%20Gestiune/taxe.dart';
import 'package:factura_sys/screens/Tranzactii/adaugaTranzactii.dart';
import 'package:factura_sys/screens/Tranzactii/asigneazaFacturi.dart';
import 'package:factura_sys/screens/Tranzactii/cautaTranzactii.dart';
import 'package:factura_sys/screens/addNewInvoiceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:tabbed_view/tabbed_view.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late TabbedViewController _controller;
  List<TabData> tabs = [];

  @override
  void initState() {
    super.initState();


    _controller = TabbedViewController(tabs);
  }


  void openTab(String tabTitle, Widget tabContent) {
    // Check if the tab is already open
    int? existingIndex;
    for (int i = 0; i < tabs.length; i++) {
      if (tabs[i].text == tabTitle) {
        existingIndex = i;
        break;
      }
    }

    if (existingIndex != null) {
      // Navigate to the existing tab
      // Ensure the index is valid before accessing
      if (existingIndex >= 0 && existingIndex < tabs.length) {
        _controller.selectedIndex = existingIndex;
      }
    } else {
      // Add a new tab and navigate to it
      tabs.add(TabData(
        draggable: false,
        text: tabTitle,
        content: Padding(
          padding: EdgeInsets.all(8),
          child: tabContent,
        ),
      ));

      // Ensure we are setting the index to the last tab
      if (tabs.isNotEmpty) {
        _controller.selectedIndex = tabs.length - 1;
      }
    }

    // Update the state to reflect changes
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    /// test
    //  openTab("tabTitle", cautaTranzactii());

    TabbedView tabbedView = TabbedView(
      controller: _controller,
      closeButtonTooltip: "Close tab",
    );
    Widget TabsWidgetDisplay = TabbedViewTheme(
      child: tabbedView,
      data: TabbedViewThemeData.minimalist(),
    );

    return AdminScaffold(
      backgroundColor: Colors.white,

      sideBar: SideBar(
        scrollController:ScrollController() ,
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            children: [
              AdminMenuItem(
                icon: Icons.confirmation_number_sharp,
                title: 'SOON',
                route: '/screen2',
              ),

            ],
          ),



          AdminMenuItem(
            title: 'Facturi',
            icon: Icons.receipt ,
            children: [
              AdminMenuItem(
                icon: Icons.add,
                title: 'Adauga Facturi',
                route: '/screen2',
              ),
            AdminMenuItem(
              icon: Icons.list,
                title: 'Articole Facturi',
                route: '/screen2',
              ),
            AdminMenuItem(
              icon: Icons.search,
                title: 'Cauta Facturi',
                route: '/c',
              ),

            ],
          ),
          AdminMenuItem(
            title: 'Tranzactii',
            icon: Icons.compare_arrows ,
            children: [
              AdminMenuItem(
                icon: Icons.add,
                title: 'Adauga Tranzactii',
                route: '/s',
              ),
              AdminMenuItem(
                icon: Icons.assignment,
                title: 'Asigneaza Facturi',
                route: '/s',
              ),
              AdminMenuItem(
                icon: Icons.search,
                title: 'Cauta Tranzactii',
                route: '/s',
              ),

            ],
          ),
          AdminMenuItem(
            title: 'Relatii Comerciale',
            icon: Icons.business ,
            children: [
              AdminMenuItem(
                icon: Icons.apartment,
                title: 'Entitati',
                route: '/s',
              ),
              AdminMenuItem(
                icon: Icons.link,
                title: 'Relatii',
                route: '/s',
              ),
              AdminMenuItem(
                icon: Icons.account_balance,
                title: 'IBAN-uri',
                route: '/s',
              ),

            ],
          ),
          AdminMenuItem(
            title: 'Angajati',
            icon: Icons.person ,
            children: [
              AdminMenuItem(
                icon: Icons.date_range,
                title: 'Concedii',
                route: '/d',
              ),
              AdminMenuItem(
                icon: Icons.document_scanner,
                title: 'Contracte Angajati',
                route: '/d',
              ),

            ],
          ),
          AdminMenuItem(
            title: 'Parc Auto',
            icon: Icons.directions_car ,
            children: [
              AdminMenuItem(
                icon: Icons.car_repair,
                title: 'Gestiune Masini',
                route: '/d',
              ),
              AdminMenuItem(
                icon: Icons.policy,
                title: 'Polite',
                route: '/d',
              ),
              AdminMenuItem(
                icon: Icons.local_gas_station,
                title: 'Consum Carburant',
                route: '/d',
              ),
              AdminMenuItem(
                icon: Icons.build,
                title: 'Intrari Service',
                route: '/d',
              ),

            ],
          ),
          AdminMenuItem(
            title: 'Setari Gestiune',
            icon: Icons.settings,
            children: [
              AdminMenuItem(
                icon: Icons.info,
                title: 'Statusuri',
                route: '/d',
              ),  AdminMenuItem(
                icon: Icons.money,
                title: 'Taxe',
                route: '/d',
              ),  AdminMenuItem(
                icon: Icons.label,
                title: 'Taguri',
                route: '/d',
              ),  AdminMenuItem(
                icon: Icons.category,
                title: 'Categorii',
                route: '/d',
              ),  AdminMenuItem(
                icon: Icons.details,
                title: 'Detalii Extra',
                route: '/d',
              ),  AdminMenuItem(
                icon: Icons.business_center,
                title: 'Firme Gestiune',
                route: '/screen2',
              ),



            ],
          ),


        ],
        selectedRoute: '/',
        onSelected: (item) {

          switch (item.title) {
            case 'Adauga Facturi':
              openTab('Adauga Facturi', adaugaFacturi());
              break;
            case 'Articole Facturi':
              openTab('Articole Facturi', articoleFacturi());
              break;
            case 'Cauta Facturi':
              openTab('Cauta Facturi', cautaFacturi());
              break;
            case 'Adauga Tranzactii':
              openTab('Adauga Tranzactii', adaugaTranzactii());
              break;
            case 'Asigneaza Facturi':
              openTab('Asigneaza Facturi', Text('Content for Asigneaza Facturi'));
              break;
            case 'Cauta Tranzactii':
              openTab('Cauta Tranzactii', cautaTranzactii());
              break;
            case 'Entitati':
              openTab('Entitati', entitati());
              break;
            case 'Relatii':
              openTab('Relatii', relatii());
              break;
            case 'IBAN-uri':
              openTab('IBAN-uri',ibanUri());
              break;
            case 'Concedii':
              openTab('Concedii',concedii());
              break;
            case 'Contracte Angajati':
              openTab('Contracte Angajati', contracteAngajati());
              break;
            case 'Gestiune Masini':
              openTab('Gestiune Masini',gestiuneMasini());
              break;
            case 'Polite':
              openTab('Polite', polite());
              break;
            case 'Consum Carburant':
              openTab('Consum Carburant', consumCarburant());
              break;
            case 'Intrari Service':
              openTab('Intrari Service', intrariService());
              break;
            case 'Statusuri':
              openTab('Statusuri',statusuri());
              break;
            case 'Taxe':
              openTab('Taxe', taxe());
              break;
            case 'Taguri':
              openTab('Taguri', taguri());
              break;
            case 'Categorii':
              openTab('Categorii', categorii());
              break;
            case 'Detalii Extra':
              openTab('Detalii Extra',detaliiExtra());
              break;
            case 'Firme Gestiune':
              openTab('Firme Gestiune', firmeGestiune());
              break;
            default:
            // Handle cases where the item title doesn't match any expected values
              openTab('Unknown', Text('No content available for this item.'));
              break;
          }


        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Header',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Footer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
         // padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height * .95 ,
            child: TabsWidgetDisplay,
          ),
        ),
      ),
    );
  }
}


