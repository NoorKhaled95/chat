import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maan_application_1/auth/data/auth_exception_handler.dart';
import 'package:maan_application_1/auth/data/auth_helper.dart';
import 'package:maan_application_1/auth/data/auth_status_enum.dart';
import 'package:maan_application_1/auth/ui/register_screen.dart';
import 'package:maan_application_1/chat/home_screen.dart';
import 'package:string_validator/string_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  GlobalKey<FormState> formkey = GlobalKey();

  saveForm() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      final status = await AuthHelper.authHelper.signIn(email, password);
      // if (status == AuthResultStatus.successful) {
      if (AuthHelper.authHelper.getCurrentUser().emailVerified) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        _showAlertDialog('Error', 'Check your email to verify account!');
        AuthHelper.authHelper.signOut(email);
      }
      // } else {
      //   final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      //   _showAlertDialog('Error', errorMsg);
      // }
    } else {
      return;
    }
  }

  String codeDialog;
  String valueText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (!isEmail(value)) {
                        return 'incorrect email syntax';
                      }
                    },
                    onChanged: (value) {
                      this.email = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.length == 0) {
                        return 'Required Field';
                      } else if (value.length < 6) {
                        return 'Password must be more than 6 letters';
                      }
                    },
                    onChanged: (value) {
                      this.password = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      onPressed: () {
                        saveForm();
                      },
                      child: Text('SUBMIT')),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, right: 20, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            ' Register',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () {
                            _showTextInputDialog(context);
                          },
                          child: Text(
                            'Forget password',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showAlertDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
          );
        });
  }

  TextEditingController _textFieldController = TextEditingController();

  Future<void> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset Password'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Enter your email"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    AuthHelper.authHelper.resetPassword(codeDialog);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
