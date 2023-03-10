import 'package:securing_documents/screens/landing_screen.dart';
import 'package:securing_documents/screens/login_screen.dart';
import 'package:securing_documents/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _db = DatabaseServices();

  Future<UserCredential> signInWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<Map<String, dynamic>> createUserWithEmail(
    String uEmail,
    String userPass,
  ) async {
    String email = _auth.currentUser!.email!;
    //verify user
    try {
      await signInWithEmail(email, userPass);
    } catch (e) {
      return {"error": true, "uid": "", "err_msg": e};
    }
    try {
      await _auth.createUserWithEmailAndPassword(email: uEmail, password: userPass);
    } catch (e) {
      return {"error": true, "uid": "", "err_msg": e};
    }
    String uid = _auth.currentUser!.uid;
    await _auth.signOut();
    try {
      await signInWithEmail(email, userPass);
      return {"error": false, "uid": uid, "err_msg": ""};
    } catch (e) {
      return {"error": true, "uid": "", "err_msg": e};
    }
  }

  Future<Map<String, dynamic>> isUserLoggedIn(BuildContext context) async {
    try {
      if (_auth.currentUser != null) {
        Map<String, dynamic> isAdmin =
            await _db.validateUser(_auth.currentUser!.uid);
        print(isAdmin);
          if (isAdmin["admin"]) {
            return {"role": "admin", "message": ""};
          } else {
            return {"role": "user", "message": ""};
          }
      } else {
        return {"role": "false", "message": "User Data Unavailable"};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return {"role": "false", "message": ""};
    }
  }

  signOutUser(BuildContext context) async {
    _auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => DashBar()),
          (route) => false);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error while logging out :- $e")));
    });
  }

  String getUid() {
    return _auth.currentUser!.uid;
  }

  Future<void> changePassword(String newPassword) {
    return _auth.currentUser!.updatePassword(newPassword);
  }
}
