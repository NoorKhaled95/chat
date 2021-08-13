import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/data/auth_helper.dart';
import 'package:maan_application_1/ui/auth/ui/login_screen.dart';
import 'package:maan_application_1/ui/chat/home_screen.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (AuthHelper.authHelper.getCurrentUser() != null) {
              return MaterialApp(home: HomeScreen());
              // return Scaffold(
              //   appBar: AppBar(title: Text('Register')),
              //   body: Center(
              //     child: Container(
              //         child: Column(
              //       children: [
              //         ElevatedButton(
              //             onPressed: () {
              //               AuthHelper.authHelper.signUp(RegisterRequest(
              //                   email: 'noshwadeh@gmail.com',
              //                   password: '987654321'));
              //               AuthHelper.authHelper.signOut('noshwadeh@gmail.com');
              //               AuthHelper.authHelper
              //                   .sendEmailVerification('noshwadeh@gmail.com');
              //               AuthHelper.authHelper.signOut('noshwadeh@gmail.com');
              //             },
              //             child: Text('Register')),
              //         ElevatedButton(
              //             onPressed: () {
              //               AuthHelper.authHelper
              //                   .signIn('noshwadeh@gmail.com', '987654321');
              //               if (AuthHelper.authHelper
              //                   .getCurrentUserId()
              //                   .emailVerified) {
              //                 print('verified!');
              //               } else {
              //                 print('not verified!');
              //                 AuthHelper.authHelper
              //                     .signOut('noshwadeh@gmail.com');
              //               }
              //             },
              //             child: Text('Sign In')),
              //         ElevatedButton(
              //             onPressed: () {
              //               AuthHelper.authHelper.signOut('noshwadeh@gmail.com');
              //             },
              //             child: Text('Signout')),
              //         ElevatedButton(
              //             onPressed: () {
              //               AuthHelper.authHelper
              //                   .resetPassword('noshwadeh@gmail.com');
              //             },
              //             child: Text('Reset password')),
              //         ElevatedButton(
              //             onPressed: () {
              //               AuthHelper.authHelper
              //                   .sendEmailVerification('noshwadeh@gmail.com');
              //             },
              //             child: Text('send verification email')),
              //       ],
              //     )),
              //   ),
              // );
            } else {
              return MaterialApp(home: LoginScreen());
            }
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error')),
            );
          } else {
            return Scaffold(
              body: Center(child: Text('Loading')),
            );
          }
        });
  }
}
