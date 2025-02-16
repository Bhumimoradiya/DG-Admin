import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var id = Uuid();
  String ref = "categories";
  void createCateory(String name) {
    String categoryId = id.v1();
    _firestore.collection(ref).doc().set({'category': name});
  }

  Future getCategories() {
    return _firestore.collection(ref).get().then((value) {
      // print("Categories : ${value.docs}");
      return value.docs;
    });
  }

  // Future getSuggestion(String suggestion) => _firestore
  //         .collection(ref)
  //         .where('category', isEqualTo: suggestion)
  //         .get()
  //         .then((value) {
  //       log("Category${value.docs}");
  //       return value.docs;
  //     });
  Future<List<String>> getSuggestion(String suggestion) async {
  QuerySnapshot querySnapshot = await _firestore
      .collection(ref)
      .where('category', isEqualTo: suggestion)
      .get();

  List<String> suggestions = querySnapshot.docs
      .map((doc) => doc['category'] as String) 
      .toList();

  log("Category $suggestions");
  return suggestions;
}

}
