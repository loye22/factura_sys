import 'package:factura_sys/provider/IntrariProvider.dart';
import 'package:factura_sys/provider/TranzactiiProvider.dart';
import 'package:factura_sys/provider/categorieProvider.dart';
import 'package:factura_sys/provider/firmGestiuneProvider.dart';
import 'package:factura_sys/provider/gestiuneMasiniProvider.dart';
import 'package:factura_sys/provider/angajatiProvider.dart';
import 'package:factura_sys/provider/concediiProvider.dart';
import 'package:factura_sys/provider/entitatiProvider.dart';
import 'package:factura_sys/provider/facturaProvider.dart';
import 'package:factura_sys/provider/ibanProvider.dart';
import 'package:factura_sys/provider/marcaMasinaProvider.dart';
import 'package:factura_sys/provider/modelMasinaProvider.dart';
import 'package:factura_sys/provider/politeProvider.dart';
import 'package:factura_sys/provider/relatiiProvider.dart';
import 'package:factura_sys/provider/statusProvider.dart';
import 'package:factura_sys/provider/taguriProvider.dart';
import 'package:factura_sys/provider/taxesProvider.dart';
import 'package:factura_sys/screens/homeScreen.dart';
import 'package:factura_sys/screens/loginScreen.dart';
import 'package:factura_sys/widgets/gestiuneMasiniDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
        apiKey: "AIzaSyD_8yYLK2N30V4LOQqzOeTHNRenwVK7BCs",
        authDomain: "facturasys-47c5c.firebaseapp.com",
        projectId: "facturasys-47c5c",
        storageBucket: "facturasys-47c5c.appspot.com",
        messagingSenderId: "495287896056",
        appId: "1:495287896056:web:9f4dcb2f8068bd07db780d",
        measurementId: "G-BYCFY4257F"),
  );
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => EntitatiProvider()),
    ChangeNotifierProvider(create: (context) => ibanProvider()),
    ChangeNotifierProvider(create: (context) => RelatiiProvider()),
    ChangeNotifierProvider(create: (context) => FacturaProvider()),
    ChangeNotifierProvider(create: (context) => AngajatiProvider()),
    ChangeNotifierProvider(create: (context) => concediiProvider()),
    ChangeNotifierProvider(create: (context) => gestinueMasiniProvider()),
    ChangeNotifierProvider(create: (context) => politeProvider()),
    ChangeNotifierProvider(create: (context) => IntrariProvider()),
    ChangeNotifierProvider(create: (context) => statusProvider()),
    ChangeNotifierProvider(create: (context) => TaxesProvider()),
    ChangeNotifierProvider(create: (context) => TaguriProvider()),
    ChangeNotifierProvider(create: (context) => categorieProvider()),
    ChangeNotifierProvider(create: (context) => firmGestiuneProvider()),
    ChangeNotifierProvider(create: (context) => TranzactiiProvider()),
    ChangeNotifierProvider(create: (context) => MarcaMasinaProvider()),
    ChangeNotifierProvider(create: (context) => modelMasinaProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true, colorScheme: Theme.of(context).colorScheme),

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return homeScreen();
          } else {
            return loginScreen();
          }
        },
      ),
      routes: {},
    );
  }
}
