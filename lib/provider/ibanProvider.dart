import 'package:factura_sys/models/iban_Model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ibanProvider with ChangeNotifier {
  List<iban_Model> _ibanList = []; // Make this nullable
  late ibanDataSource _ibanDataSources;

  // Getter for entitatiDataSource
  ibanDataSource get ibanDataSources => _ibanDataSources;

  // Check if data has already been fetched
  bool get hasData => _ibanList != null && _ibanList!.isNotEmpty;


  ibanProvider() {
    fetchIbanFromFirebase();
  }

  Future<void> fetchIbanFromFirebase() async {
    // Skip fetching if data is already present
    if (_ibanList!.isNotEmpty) {
      print("the data came from the provider ");
      return;
    }
    print("calling the api ");

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      firestore
          .collection('ibans')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((querySnapshot) {
        List<iban_Model> ibantiListHelper = [];
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data["docId"] = doc.id;
          iban_Model iban = iban_Model(


            docId: doc.id,

            userEmail: data['userEmail'] ?? "NOTFOUND",
            banca: data['banca'] ?? "NOTFOUND",
            contPropriu: data['contPropriu' ] ?? false ,
            cuiTitular: data['cuiTitular'] ?? "NOTFOUND",

            denumireTitular: data['denumireTitular'] ?? "NOTFOUND",
            iban: data['iban'] ?? "NOTFOUND",
            moneda: data['moneda'] ?? "NOTFOUND",

            soldInitial: data['soldInitial'] ?? 0.0,
            soldCurent:data["soldCurent"] ?? 0.0 ,

            timestamp: data['timestamp']?.toDate() ?? DateTime(1800) ,
            dataPrimaTranzactieExtras:  data['dataPrimaTranzactieExtras']?.toDate() ?? null ,
            dataUltimaTranzactie: data["dataUltimaTranzactie"]?.toDate() ??  null ,
          );

          ibantiListHelper.add(iban);
        }

        _ibanList = ibantiListHelper;
        _ibanDataSources = ibanDataSource(ibans: _ibanList);
        notifyListeners(); // Notify UI about changes
      });
    } catch (e) {
      print('Error fetching entities: $e');
      // Handle error (e.g., show a SnackBar, etc.)
    }
  }

  // Refresh method if you want to force re-fetch
  Future<void> refreshData() async {
    _ibanList = []; // Clear cache
    await fetchIbanFromFirebase(); // Fetch fresh data
  }

  // Method to add a new entity to Firebase
  Future<void> addIban(
      {required BuildContext context,
      required Map<String, dynamic> data}) async {
    try {
      String refdocId = "";
      // Add the entity to Firebase
      await FirebaseFirestore.instance.collection('ibans').add(data).then((doc){
        refdocId = doc.id ;
        print(doc.id);
        print(data);
      });


      // Create the model from the data
      iban_Model newIBAN = iban_Model(
        docId: refdocId,
        iban: data['iban'],
        banca: data['banca'],
        cuiTitular: data['cuiTitular'],
        denumireTitular: data['denumireTitular'],
        moneda: data['moneda'],
        contPropriu: data['contPropriu'],
        soldInitial: data['soldInitial']?.toDouble() ?? 0.0, // Convert to double
        soldCurent: data['soldCurent']?.toDouble() ?? 0.0,   // Convert to double
        userEmail: data['userEmail'],
        timestamp: data['timestamp'] ?? DateTime(1800), // Assuming timestamp is stored as Timestamp in Firestore
        dataPrimaTranzactieExtras: data['dataPrimaTranzactieExtras'] ?? DateTime(1800),
        dataUltimaTranzactie: data['dataUltimaTranzactie']??  DateTime(1800),
      );

      // Add the new entity to the local list and update the data source
      _ibanList?.add(newIBAN);
      _ibanDataSources = ibanDataSource(ibans: _ibanList!);

      // Notify listeners so UI updates
      notifyListeners();

      // Show success message
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: "Entitate adăugată cu succes!",
        ),
      );
    } catch (e) {
      print('Error adding entity: $e');
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message:
              "Eroare la adăugarea entității. Vă rugăm să încercați din nou.",
        ),
      );
    }
  }
}
