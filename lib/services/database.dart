import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:partysnacks/common/common.dart';
// import 'package:location/location.dart';

class DatabaseService {
  final String uid;
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DatabaseService({this.uid});
  // collection reference

  Future<void> updateUserData(String mode, String email) async {
    CollectionReference userCollection = firestore.collection('users');

    print("New Useer---------$uid");

    return await userCollection.doc(uid).set({
      'uid': uid,
      'email': email,
      'mode': mode,
      'date': currDate,
      'pic': '',
      'name': '',
      'mobile': '',
      'address': '',
      'pin': '',
    });
  }

  //update user profile

  // register with email and password
  Future updateUserProfile(String uid, String pic, String name, String mobile,
      String address, String pin) async {
    CollectionReference userCollection = firestore.collection('users');
    try {
      return await userCollection.doc(uid).update({
        'pic': pic,
        'name': name,
        'mobile': mobile,
        'address': address,
        'pin': pin,
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
