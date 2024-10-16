import 'package:factura_sys/models/entitati_Model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EntitatiProvider with ChangeNotifier {
  List<entitati_Model> _entitatiList = [] ;  // Make this nullable
  late entitatiDataSource _entitatiDataSources;

  // Getter for entitatiDataSource
  entitatiDataSource get entitatiDataSources => _entitatiDataSources;

  // Check if data has already been fetched
  bool get hasData => _entitatiList != null && _entitatiList!.isNotEmpty;

  EntitatiProvider() {
    fetchEntitatiFromFirebase();
  }


  Future<void> fetchEntitatiFromFirebase() async {
    // Skip fetching if data is already present
    if (_entitatiList!.isNotEmpty) {
      print("the data came from the provider ");
      return;
    }
    print("calling the api ");

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      firestore
          .collection('entitati')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((querySnapshot) {
        List<entitati_Model> entitatiListHelper = [];
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data["docId"] = doc.id;

          entitati_Model entitate = entitati_Model(
            docId: doc.id,
            denumire: data['denumire'] ?? 'NOTFOUND',
            tip: data['tip'] ?? 'NOTFOUND',
            cuiEntitate: data['cui'] ?? 'NOTFOUND',
            timestamp: data['timestamp']?.toDate() ?? DateTime(1800),
            userEmail: data['userEmail'] ?? "NOTFOUND",
          );
          entitatiListHelper.add(entitate);
        }

        _entitatiList = entitatiListHelper;
        _entitatiDataSources = entitatiDataSource(orders: _entitatiList!);
        notifyListeners();  // Notify UI about changes

      });
    } catch (e) {
      print('Error fetching entities: $e');
      // Handle error (e.g., show a SnackBar, etc.)
    }
  }

  // Refresh method if you want to force re-fetch
  Future<void> refreshData() async {
    _entitatiList = [];  // Clear cache
    await fetchEntitatiFromFirebase();  // Fetch fresh data
  }

  // Method to add a new entity to Firebase
  Future<void> addEntitate({required BuildContext context,required Map<String, dynamic> data}) async {
    try {
      // Add the entity to Firebase
      await FirebaseFirestore.instance.collection('entitati').add(data);

      // Create the model from the data
      entitati_Model newEntitate = entitati_Model(
        docId: '',  // docId will be assigned by Firestore, so we can leave it empty
        denumire: data['denumire'] ?? '',
        tip: data['tip'] ?? '',
        cuiEntitate: data['cui'] ?? '',
        timestamp: data['timestamp'],  // Ensure the timestamp is in the correct format
        userEmail: data['userEmail'] ?? "NOTFOUND",
      );

      // Add the new entity to the local list and update the data source
      _entitatiList?.add(newEntitate);
      _entitatiDataSources = entitatiDataSource(orders: _entitatiList!);

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
          message: "Eroare la adăugarea entității. Vă rugăm să încercați din nou. $e",
        ),
      );
    }
  }


}
