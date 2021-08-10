import 'package:firebase_auth/firebase_auth.dart';
import 'package:maan_application_1/auth/models/register_request.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signUp(RegisterRequest registerRequest) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
            email: registerRequest.email, password: registerRequest.password);
    print(userCredential.user.uid);
    print(await userCredential.user.getIdToken());
  }

  signIn(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    print(userCredential.user.uid);
    print(await userCredential.user.getIdToken());
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

  User getCurrentUserId() {
    return firebaseAuth.currentUser;
  }
}
