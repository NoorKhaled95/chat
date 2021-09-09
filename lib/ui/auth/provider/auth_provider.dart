import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maan_application_1/ui/auth/data/auth_helper.dart';
import 'package:maan_application_1/ui/auth/data/firestorage_helper.dart';
import 'package:maan_application_1/ui/auth/data/firestore_helper.dart';
import 'package:maan_application_1/ui/auth/models/register_request.dart';
import 'package:maan_application_1/ui/auth/models/user_models.dart';
import 'package:maan_application_1/ui/chat/ui/chat_page.dart';
import 'package:maan_application_1/ui/chat/ui/edit_screen.dart';
import 'package:maan_application_1/ui/auth/ui/login_screen.dart';
import 'package:maan_application_1/ui/chat/ui/profile_page.dart';
import 'package:maan_application_1/ui/helpers/route_helper.dart';
import 'package:maan_application_1/widgets/flutter_toast.dart';
import 'package:maan_application_1/widgets/progress_dialogue.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    if (checkUser()) {
      getUserFormFirestore(AuthHelper.authHelper.getUserId());
    }
  }

  checkUser() {
    return AuthHelper.authHelper.checkUser();
  }

  UserModel userModel;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Gender selectedGender;

  editProfileNavigation() {
    userNameController.text = userModel.userName;
    countryController.text = userModel.country;
    cityController.text = userModel.city;
    phoneController.text = userModel.phoneNumber;
    selectedGender = userModel.gender;
    RouteHelper.routeHelper.goToPage(EditScreen.routeName);
  }

  editProfile() {
    userModel.userName = userNameController.text;
    userModel.country = countryController.text;
    userModel.city = cityController.text;
    userModel.phoneNumber = phoneController.text;
    userModel.gender = selectedGender;

    updateUser();
  }

  saveGender(Gender gender) {
    this.selectedGender = gender;
    notifyListeners();
  }

  nullValidate(String v) {
    if (v == null || v.length == 0) {
      return 'Required Field';
    }
  }

  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  GlobalKey<FormState> editKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> resetPasswordKey = GlobalKey<FormState>();
  TextStyle headingStyle = TextStyle(fontSize: 14, color: Color(0xff8276EB));
  TextStyle headingStyleName = TextStyle(
      fontSize: 20, color: Color(0xff000000), fontWeight: FontWeight.w800);

  TextStyle bodyStyle = TextStyle(fontSize: 14, color: Colors.black);

  registerNewUser() async {
    if (registerKey.currentState.validate()) {
      ProgressDialoge().show();
      RegisterRequest registerRequest = RegisterRequest(
          city: cityController.text,
          country: countryController.text,
          userName: userNameController.text,
          email: emailController.text,
          password: passwordController.text,
          gender: selectedGender,
          phoneNumber: phoneController.text);

      UserCredential userCredential = await signup(registerRequest);
      registerRequest.id = userCredential.user.uid;
      setUserInFirestore(registerRequest);
      ProgressDialoge().dismiss();

      await verifyEmail();

      RouteHelper.routeHelper.goAndReplacePage(LoginScreen.routeName);
    }
  }

  loginUser() async {
    if (loginKey.currentState.validate()) {
      ProgressDialoge().show();
      UserCredential userCredential = await login();
      if (userCredential.user.emailVerified) {
        getUserFormFirestore(userCredential.user.uid);
        ProgressDialoge().dismiss();
        RouteHelper.routeHelper.goAndReplacePage(ChatPage.routeName);
      } else {
        ProgressDialoge().dismiss();
        verifyEmail();
      }
    }
  }

  File file;
  setFile(File file) {
    this.file = file;
    notifyListeners();
  }

  updateUserImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(file.path);

    String imageUrl =
        await FireStorageHelper.fireStorageHelper.uploadImage(this.file);
    userModel.imageUrl = imageUrl;
    updateUserImage();
  }

  Future<UserCredential> signup(RegisterRequest registerRequest) async {
    UserCredential userCredential =
        await AuthHelper.authHelper.signup(registerRequest);
    return userCredential;
  }

  Future<UserCredential> login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .login(emailController.text, passwordController.text);
    return userCredential;
  }

  resetPassword(String email) {
    if (resetPasswordKey.currentState.validate()) {
      AuthHelper.authHelper.resetPassword(email);
      FlutterToast('please chech your email to reset password').showMessage();
      RouteHelper.routeHelper.goBack();
    }
  }

  verifyEmail() async {
    await AuthHelper.authHelper.verifyEmail();
    FlutterToast('please check your email to verify your account')
        .showMessage();
    logout();
  }

  sendVerifyEmail() async {
    if (loginKey.currentState.validate()) {
      await AuthHelper.authHelper.verifyEmail();
      FlutterToast('please chech your email to verify your account')
          .showMessage();
      logout();
    }
  }

  logout() async {
    AuthHelper.authHelper.logout();
    emailController.clear();
    passwordController.clear();
    userNameController.clear();
    countryController.clear();
    cityController.clear();
    phoneController.clear();
  }

  getUserFormFirestore(String userId) async {
    this.userModel =
        await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    notifyListeners();
  }

  setUserInFirestore(RegisterRequest registerRequest) async {
    print(registerRequest.toMap());
    FirestoreHelper.firestoreHelper.saveUserInFirestore(registerRequest);
  }

  updateUser() async {
    if (editKey.currentState.validate()) {
      ProgressDialoge().show();
      ProgressDialoge().dismiss();
      await FirestoreHelper.firestoreHelper.updateUserFromFirestore(userModel);
      getUserFormFirestore(userModel.id);
      RouteHelper.routeHelper.goAndReplacePage(ProfilePage.routeName);
      notifyListeners();
    }
  }

  updateImageUser() async {
    ProgressDialoge().show();
    ProgressDialoge().dismiss();
    await FirestoreHelper.firestoreHelper.updateUserFromFirestore(userModel);
    getUserFormFirestore(userModel.id);
    RouteHelper.routeHelper.goAndReplacePage(ProfilePage.routeName);
    notifyListeners();
  }

  User getCurrentUser() {
    return AuthHelper.authHelper.getCurrentUser();
  }
}
