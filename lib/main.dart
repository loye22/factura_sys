import 'package:factura_sys/screens/homeScreen.dart';
import 'package:factura_sys/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        measurementId: "G-BYCFY4257F"
    ),
  );
  await Firebase.initializeApp();

  runApp(MyApp());
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
      routes: {

      },
    );
  }
}