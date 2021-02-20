import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haanzi_main/common/common.dart';
import 'package:location/location.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<void> updateUserData(String mode, String email) async {
    print("New Useer---------$uid");

    return await userCollection.document(uid).setData({
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
    try {
      return await userCollection.document(uid).updateData({
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
