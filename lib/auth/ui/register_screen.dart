import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maan_application_1/auth/data/auth_exception_handler.dart';
import 'package:maan_application_1/auth/data/auth_helper.dart';
import 'package:maan_application_1/auth/data/auth_status_enum.dart';
import 'package:maan_application_1/auth/models/register_request.dart';
import 'package:string_validator/string_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String userName = '';
  String email = '';
  String password = '';
  String phoneNumber = '';
  String city = '';
  String country = '';
  String gender;

  GlobalKey<FormState> formkey = GlobalKey();

  saveForm() {
    if (formkey.currentState.validate()) {
      if (gender != null) {
        formkey.currentState.save();
        final status = AuthHelper.authHelper
            .signUp(RegisterRequest(email: email, password: password));
        // if (status == AuthResultStatus.successful) {
        AuthHelper.authHelper.sendEmailVerification(email);
        _showAlertDialog('Verification', 'Check your email to verify account!');
        AuthHelper.authHelper.signOut(email);
        Navigator.pop(context);
        // } else {
        //   final errorMsg =
        //       AuthExceptionHandler.generateExceptionMessage(status);
        //   _showAlertDialog('Error', errorMsg);
        // }
      } else {
        _showAlertDialog('Error', 'you have to determined your gender');
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 64),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Registration',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                TextFormField(
                  // validator: (value) {
                  //   if (value.length == 0) {
                  //     return 'Required Field';
                  //   } else if (value.length < 5) {
                  //     return 'User Name must be larger than 5 letters';
                  //   }
                  // },
                  onChanged: (value) {
                    this.userName = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'User Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
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
                TextFormField(
                  // validator: (value) {
                  //   if (value.length == 0) {
                  //     return 'Required Field';
                  //   } else if (value.length < 10) {
                  //     return 'Phone number must be 10 digits';
                  //   }
                  // },
                  onChanged: (value) {
                    this.phoneNumber = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // validator: (value) {
                  //   if (value.length == 0) {
                  //     return 'Required Field';
                  //   } else if (value.length < 2) {
                  //     return 'City must be more than 2 letters';
                  //   }
                  // },
                  onChanged: (value) {
                    this.city = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // validator: (value) {
                  //   if (value.length == 0) {
                  //     return 'Required Field';
                  //   } else if (value.length < 2) {
                  //     return 'Country must be more than 2 letters';
                  //   }
                  // },
                  onChanged: (value) {
                    this.country = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gender'),
                          RadioListTile(
                              title: Text('Male'),
                              value: 'male',
                              groupValue: gender,
                              onChanged: (value) {
                                this.gender = value;
                                setState(() {});
                              }),
                          RadioListTile(
                              title: Text('Female'),
                              value: 'female',
                              groupValue: gender,
                              onChanged: (value) {
                                this.gender = value;
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                  ],
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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Do you have an account? Login',
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
}
