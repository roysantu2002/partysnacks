import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String admin;
  Timestamp accountCreated;
  String fullName;
  String pic;
  String mobile;
  String address;
  String pin;

  UserModel({
    this.uid,
    this.email,
    this.admin,
    this.accountCreated,
    this.fullName,
    this.pic,
    this.mobile,
    this.address,
    this.pin,
  });

  // // UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
  // //   uid = doc.documentID;
  // //   email = doc.data['email'];
  // //   accountCreated = doc.data['accountCreated'];
  // //   fullName = doc.data['fullName'];
  // //   groupId = doc.data['groupId'];
  // //   notifToken = doc.data['notifToken'];
  // }
}
