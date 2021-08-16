import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/data/auth_helper.dart';
import 'package:maan_application_1/ui/auth/models/register_request.dart';
import 'package:maan_application_1/ui/auth/ui/widgets/custom_textfield.dart';
import 'package:maan_application_1/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email;
  String password;
  String userName;
  Gender gender;
  String phoneNumber;
  String city;
  String country;

  saveEmail(v) => this.email = v;

  savePassword(v) => this.password = v;

  saveUserName(v) => this.userName = v;

  saveGender(v) => this.gender = v;

  savePhone(v) => this.phoneNumber = v;

  saveCity(v) => this.city = v;

  saveCountry(v) => this.country = v;

  nullValidate(String v) {
    if (v == null || v.length == 0) {
      return 'Required Field';
    }
  }

  registerUser() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      RegisterRequest registerRequest = RegisterRequest(
          email: email,
          password: password,
          userName: userName,
          gender: gender,
          phoneNumber: phoneNumber,
          city: city,
          country: country);
      AuthHelper.authHelper.signUp(registerRequest, context);
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/back.jpg'),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   constraints: BoxConstraints.expand(),
        //   child:
        Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.transparent,
      // extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 64),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 100.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                // Center(
                //   child: Text(
                //     'Registration',
                //     style:
                //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
                SizedBox(
                  height: 32,
                ),
                CustomTextfeild(
                  label: 'Email',
                  save: saveEmail,
                  textInputType: TextInputType.emailAddress,
                  validate: nullValidate,
                ),
                CustomTextfeild(
                  label: 'Password',
                  isHidden: true,
                  save: savePassword,
                  validate: nullValidate,
                ),
                CustomTextfeild(
                  label: 'UserName',
                  save: saveUserName,
                  validate: nullValidate,
                ),
                CustomTextfeild(
                  label: 'Phone',
                  save: savePhone,
                  validate: nullValidate,
                ),
                CustomTextfeild(
                  label: 'Country',
                  save: saveCountry,
                  validate: nullValidate,
                ),
                CustomTextfeild(
                  label: 'City',
                  save: saveCity,
                  validate: nullValidate,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 15, left: 20),
                              child: Text('Gender')),
                          RadioListTile(
                              title: Text('Male'),
                              value: Gender.male,
                              groupValue: gender,
                              onChanged: (value) {
                                saveGender(value);
                                setState(() {});
                              }),
                          RadioListTile(
                              title: Text('Female'),
                              value: Gender.female,
                              groupValue: gender,
                              onChanged: (value) {
                                saveGender(value);
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                  ],
                ),
                CustomButton(title: 'Register', function: registerUser),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Do you have an account? Login',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0Xffdd5a44),
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
      // ),
    );
  }
}
