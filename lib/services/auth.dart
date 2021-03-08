import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebaseuser
  User _userFromFirebaseUser(User user) {
    return user != null ? user : null;
  }

  // auth change user stream
  Stream<User> get user {
    print("################# USER #################");

    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  // Sign in anonoymously
  Future signInAnon() async {
    try {
      UserCredential authUser = await _auth.signInAnonymously();
      User user = authUser.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email/password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authUser.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email/password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = authUser.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
