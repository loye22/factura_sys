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

    tabs.add(TabData(
      text: 'Tab 1',
      leading: (context, status) => Icon(Icons.star, size: 16),
      content: Padding(
        padding: EdgeInsets.all(8),
        child: Text('Hello'),
      ),
    ));

    tabs.add(TabData(
      text: 'Tab 2',
      content: Padding(
        padding: EdgeInsets.all(8),
        child: Text('Hello again'),
      ),
    ));

    tabs.add(TabData(
      text: 'TextField',
      content: Padding(
        padding: EdgeInsets.all(8),
        child: TextField(
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
          ),
        ),
      ),
      keepAlive: true,
    ));

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
      _controller.selectedIndex = existingIndex;
    } else {
      // Add a new tab and navigate to it
      tabs.add(TabData(
        text: tabTitle,
        leading: (context, status) => Icon(Icons.star, size: 16),
        content: Padding(
          padding: EdgeInsets.all(8),
          child: tabContent,
        ),
      ));
      _controller.selectedIndex = tabs.length - 1;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TabbedView tabbedView = TabbedView(

      controller: _controller,
      closeButtonTooltip: "Close tab",
    );
    Widget w = TabbedViewTheme(
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

          if (item.title == 'Firme Gestiune') {
            openTab('Third Level Item 1', Text('Content for Third Level Item 1'));
          } else if (item.title == 'Third Level Item 2') {
            openTab('Third Level Item 2', Text('Content for Third Level Item 11'));
          } else if (item.title == 'Second Level Item 1') {
            openTab('Second Level Item 1', Text('Content for Third Level Item 111'));
          } else if (item.title == 'Second Level Item 2') {
            openTab('Second Level Item 2', Text('Content for Third Level Item 111'));
          }else if (item.title == 'Second Level Item 2') {
            openTab('1st Level Item1', Text('Content for Third Level Item 11111'));
          }else if (item.title == 'Categorii') {
            openTab('Categorii', Container(width: 500, height: 800, color: Colors.green, child: Text('Content for Third Level Item 111111'),));
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
          padding: const EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height,
            child: w,
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:tabbed_view/tabbed_view.dart';
//
// class homeScreen extends StatefulWidget {
//   const homeScreen({super.key});
//
//   @override
//   State<homeScreen> createState() => _homeScreenState();
// }
//
// class _homeScreenState extends State<homeScreen> {
//   Container currentScreen = Container(
//     decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//   );
//
//   late TabbedViewController _controller;
//   List<TabData> tabs = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     tabs.add(TabData(
//
//         text: 'Tab 1',
//         leading: (context, status) => Icon(Icons.star, size: 16),
//         content: Padding(child: Text('Hello'), padding: EdgeInsets.all(8))));
//     tabs.add(TabData(
//         text: 'Tab 2',
//         content:
//             Padding(child: Text('Hello again'), padding: EdgeInsets.all(8))));
//     tabs.add(TabData(
//
//         text: 'TextField',
//         content: Padding(
//             child: TextField(
//                 decoration: InputDecoration(
//                     isDense: true, border: OutlineInputBorder())),
//             padding: EdgeInsets.all(8)),
//         keepAlive: true));
//
//     _controller = TabbedViewController(tabs);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TabbedView tabbedView = TabbedView(controller: _controller,closeButtonTooltip: "Close tap",);
//     Widget w =
//         TabbedViewTheme(child: tabbedView, data: TabbedViewThemeData.minimalist());
//
//     return AdminScaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Sample'),
//       ),
//       sideBar: SideBar(
//         items: const [
//           AdminMenuItem(
//             children: [
//               AdminMenuItem(
//                 title: 'Second Level Item 1',
//                 route: '/screen2',
//               ),
//               AdminMenuItem(
//                 title: 'xxx',
//                 children: [AdminMenuItem(
//                   title: 'Second Level Item 1',
//                   route: '/screen2',
//                 ),]
//               ),
//             ],
//             title: 'Dashboard',
//             route: '/screen2',
//             icon: Icons.dashboard,
//           ),
//           AdminMenuItem(
//             title: 'Top Level',
//             icon: Icons.file_copy,
//             children: [
//               AdminMenuItem(
//                 title: 'Second Level Item 1',
//                 route: '/screen2',
//               ),
//               AdminMenuItem(
//                 title: 'Second Level Item 2',
//                 route: '/secondLevelItem2',
//               ),
//               AdminMenuItem(
//                 title: 'Third Level',
//                 children: [
//                   AdminMenuItem(
//                     title: 'Third Level Item 1',
//                     route: '/thirdLevelItem1',
//                   ),
//                   AdminMenuItem(
//                     title: 'Third Level Item 2',
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//         selectedRoute: '/',
//         onSelected: (item) {
//
//           if (item.title == 'Third Level Item 2') {
//             tabs.add(TabData(
//                 text: 'Tab 1',
//                 leading: (context, status) => Icon(Icons.star, size: 16),
//                 content: Padding(child: Text('Third Level Item 2'), padding: EdgeInsets.all(8))));
//
//           }
//           if (item.title == 'Third Level Item 1') {
//             tabs.add(TabData(
//                 text: 'Tab 1',
//                 leading: (context, status) => Icon(Icons.star, size: 16),
//                 content: Padding(child: Text('Third Level Item 1'), padding: EdgeInsets.all(8))));
//
//           }
//           if (item.title == 'Second Level Item 1') {
//             tabs.add(TabData(
//                 text: 'Tab 1',
//                 leading: (context, status) => Icon(Icons.star, size: 16),
//                 content: Padding(child: Text('Second Level Item 1'), padding: EdgeInsets.all(8))));
//
//           }
//           if (item.title == 'Second Level Item 2') {
//             tabs.add(TabData(
//                 text: 'Tab 1',
//                 leading: (context, status) => Icon(Icons.star, size: 16),
//                 content: Padding(child: Text('Second Level Item 2'), padding: EdgeInsets.all(8))));
//
//           }
//           setState(() {});
//         },
//         header: Container(
//           height: 50,
//           width: double.infinity,
//           color: const Color(0xff444444),
//           child: const Center(
//             child: Text(
//               'header',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         footer: Container(
//           height: 50,
//           width: double.infinity,
//           color: const Color(0xff444444),
//           child: const Center(
//             child: Text(
//               'footer',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           alignment: Alignment.topLeft,
//           padding: const EdgeInsets.all(10),
//           child:  Container(
//             width: MediaQuery.of(context).size.width * .8,
//               height: MediaQuery.of(context).size.height ,
//               child: w,),
//         ),
//       ),
//     );
//   }
//
//
//
// }
