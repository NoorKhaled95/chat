import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/models/register_request.dart';
import 'package:maan_application_1/ui/chat/home_screen.dart';
import 'package:maan_application_1/ui/helpers/custom_dialoug.dart';

import 'firestore_helper.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signUp(RegisterRequest registerRequest, context) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: registerRequest.email, password: registerRequest.password);
      String id = userCredential.user.uid;
      registerRequest.id = id;

      await FirestoreHelper.firestoreHelper
          .saveUserInFirestore(registerRequest);
      await firebaseAuth.currentUser.sendEmailVerification();
      signOut(registerRequest.email);
      Navigator.pop(context);
      CustomDialoug.customDialoug.showCustomDialoug(context, 'Success',
          'Averification Email has been sent, please verify your email before logging');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'Error', 'Password should be at least 6 characters');
      } else if (e.code == 'email-already-in-use') {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'Error', 'The account already exists for that email');
      }
    } catch (e) {
      CustomDialoug.customDialoug
          .showCustomDialoug(context, 'Error', e.toString());
    }
  }

  signIn(String email, String password, context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user.emailVerified) {
        throw Exception('You have to verify your Email');
      }

      await FirestoreHelper.firestoreHelper
          .getUserFromFirestore(userCredential.user.uid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'Error', 'Wrong password provided for that user.');
      }
    } catch (e) {
      CustomDialoug.customDialoug
          .showCustomDialoug(context, 'Error', e.toString());
    }
  }

  resetPassword(String email, context) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  sendEmailVerification(String email, String password, context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user.emailVerified) {
        await firebaseAuth.currentUser.sendEmailVerification();
        signOut(email);
        CustomDialoug.customDialoug.showCustomDialoug(
            context,
            'Email Verification',
            'email verification sent, check your email please');
      } else {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'Email Verification', 'Your email verified!');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'Error', 'Wrong password provided for that user.');
      }
    } catch (e) {
      CustomDialoug.customDialoug
          .showCustomDialoug(context, 'Error', e.toString());
    }
  }

  signOut(String email) {
    firebaseAuth.signOut();
  }

  User getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}
