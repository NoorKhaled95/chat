import 'package:firebase_auth/firebase_auth.dart';
import 'package:maan_application_1/ui/auth/models/register_request.dart';
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
          .saveUserInFirestore(registerRequest)(registerRequest);
      await sendEmailVerification(registerRequest.email);
      signOut(registerRequest.email);
      CustomDialoug.customDialoug.showCustomDialoug(context, 'Success',
          'Averification Email has been sent, please verify your email before logging');
    } on Exception catch (e) {
      print(e);
    }
  }

  signIn(String email, String password, context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user.emailVerified) {
        throw Exception('You have to verify your Email');
      }
      // assert(
      //     userCredential.user.emailVerified, 'You have to verify your Email');

      FirestoreHelper.firestoreHelper
          .getUserFromFirestore(userCredential.user.uid);
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

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  sendEmailVerification(String email) async {
    await firebaseAuth.currentUser.sendEmailVerification();
  }

  signOut(String email) {
    firebaseAuth.signOut();
  }

  User getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}
