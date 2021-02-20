import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

final now = new DateTime.now();

final String currDate = (new DateFormat("dd-MM-yyyy").format(now)).toString();

//FirebaseAuth _auth = FirebaseAuth.instance;

/*String animatedSplash = '../screen/splashScreen',
        profilePage = '../screen/profile',*/

class Auth {
  FirebaseAuth _firebaseAuth;
  FirebaseUser _user;

  Auth() {
    this._firebaseAuth = FirebaseAuth.instance;
  }
}

// final FirebaseUser currentUser = await _auth.currentUser();
//assert(user.uid == currentUser.uid);
