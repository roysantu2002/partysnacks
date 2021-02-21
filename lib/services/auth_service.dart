import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:partysnacks/services/database.dart';
// import 'package:partysnacks/models/user.dart';

class AuthService {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;
  final GoogleSignIn gooleSignIn = GoogleSignIn();

  AuthService(this._auth);
  //FirebaseApp defaultApp = await Firebase.initializeApp();

  Future<String> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

// Future<void> signOutGoogle() async {
//   await googleSignIn.signOut();

//   print("User Signed Out");
// }

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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String mode) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      print("userID--------$user.uid");

      //await DatabaseService(uid: user.uid).updateUserData(mode, email);
      return user;
    } catch (error) {
      print(error.message.toString());
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User> getCurrentUser() async {
    User currentUser = _auth.currentUser;
    return currentUser;
  }

  // many unhandled google error exist
// will push them soon
  Future<bool> googleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      User user = result.user;
      print(user.uid);
    }
    return Future.value(true);
  }
}
