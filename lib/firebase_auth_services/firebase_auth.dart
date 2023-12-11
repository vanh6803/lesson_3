import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      context, String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.cancel_outlined, color: Colors.red),
                ),
                Text('The email address is already in use.'),
              ],
            ),
            duration: Durations.extralong3,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.cancel_outlined, color: Colors.red),
                ),
                Text('An error occurred: ${e.code}'),
              ],
            ),
            duration: Durations.extralong3,
          ),
        );
      }
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (!credential.user!.emailVerified) {
        print('a');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.cancel_outlined, color: Colors.red),
                ),
                Text('Email is not verify'),
              ],
            ),
          ),
        );
        return null;
      }
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.cancel_outlined, color: Colors.red),
                ),
                Text('Invalid email or password.'),
              ],
            ),
            duration: Durations.extralong3,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.cancel_outlined, color: Colors.red),
                ),
                Text('An error occurred: ${e.code}'),
              ],
            ),
            duration: Durations.extralong3,
          ),
        );
      }
    }
    return null;
  }
}
