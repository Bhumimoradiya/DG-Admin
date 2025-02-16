import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dg_admin/db/UserModel.dart';

class UserDetail{
  final _db = FirebaseFirestore.instance;

    Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db
        .collection("User_Details")
        .where("Email_Id", isEqualTo: email)
        .get();

    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    log("USER DATA ----1------- $userData");
    return userData;
  }
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'User_Details';
  Future allUSer() async {
    // final snapshot = await _db.collection("User_Details").get();
    // final userData =
    //     snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    // log("USER DATA -----2------ $userData");
    // return userData;
     return _firestore.collection(ref).get().then((value) {
      return value.docs;
    });
  }
}