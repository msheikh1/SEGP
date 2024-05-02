import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_school/services/database.dart';

// This class provides authentication services.
class AuthService {
  // The instance of FirebaseAuth.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // This method signs in a user with email and password.
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Attempt to sign in the user.
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Return the user if sign in was successful.
      return userCredential.user;
    } catch (e) {
      // Print any errors that occur during sign in.
      print('Error signing in with email and password: $e');
      return null;
    }
  }

  // This method signs out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // This method returns the current user.
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // This method signs in a user anonymously.
  Future signInAnon() async {
    try {
      // Attempt to sign in the user anonymously.
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      // Print any errors that occur during sign in.
      print(e.toString());
      return null;
    }
  }

  // This method registers a new user with email and password.
  Future<UserCredential?> register(email, password, String name) async {
    try {
      // Attempt to register the user.
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Return the user if registration was successful.
      return userCredential;
    } catch (e) {
      // Print any errors that occur during registration.
      print('Error registering user: $e');
      return null;
    }
  }
}