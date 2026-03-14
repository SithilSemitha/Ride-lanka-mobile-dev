import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ride_lanka/core/constants/app_dialogs.dart';
import '../models/user_model.dart';

class AuthService {
  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('Weak password');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('Email already exists');
      }

      return null;
    }
  }

  Future<void> saveUser(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(user.toMap());
  }

  Future<User?> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        AppDialogs.loginFailedDialog(context);
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
