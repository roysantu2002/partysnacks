import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:partysnacks/services/database.dart';
// import 'package:partysnacks/models/user.dart';

class AuthService {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  AuthService(this._auth);
  //FirebaseApp defaultApp = await Firebase.initializeApp();

  Stream<User> get authStateChanges => _auth.authStateChanges();

  // GET UID
  Future<String> getCurrentUID() async {
    return _auth.currentUser.uid;
  }

  // // auth change user stream
  // Stream<User> get user {
  //   return _auth.authStateChanges
  //       //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  //       .map(_userFromFirebaseUser);
  // }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return user.toString();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future<String> registerWithEmailAndPassword(
      String email, String password, String mode) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      print("userID--------$user.uid");

      //await DatabaseService(uid: user.uid).updateUserData(mode, email);
      return user.toString();
    } catch (error) {
      print(error.message.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<User> getCurrentUser() async {
    User currentUser = _auth.currentUser;
    return currentUser;
  }
}
