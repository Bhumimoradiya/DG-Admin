import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'brands';
  var id = Uuid();
  void createBrand(String name) {
    String brandId = id.v1();
    _firestore.collection(ref).doc().set({'brand': name});
  }

  Future getbrands() {
    return _firestore.collection(ref).get().then((value) {
      return value.docs;
    });
  }
  Future<List<String>> getSuggestion(String suggestion) async {
  QuerySnapshot querySnapshot = await _firestore
      .collection(ref)
      .where('brand', isEqualTo: suggestion)
      .get();

  List<String> suggestions = querySnapshot.docs
      .map((doc) => doc['brand'] as String) 
      .toList();

  // log("Brand $suggestions");
  return suggestions;
}
}
