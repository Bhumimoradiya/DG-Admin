import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String mobile_no;
  final String email_id;

  const UserModel({
    this.id,
    required this.name,
    required this.mobile_no,
    required this.email_id,
  });

  toJson() {
    return {
      "User_Id": id,
      "Name": name,
      "Mobile_No": mobile_no,
      "Email_Id": email_id,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data["Name"],
      mobile_no: data["Mobile_No"],
      email_id: data["Email_Id"],
    );
  }
}
