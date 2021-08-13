import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/data/auth_helper.dart';
import 'package:maan_application_1/ui/auth/ui/register_screen.dart';
import 'package:maan_application_1/ui/auth/ui/widgets/custom_textfield.dart';
import 'package:maan_application_1/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  String valueText;
  String codeDialog;

  saveEmail(v) => this.email = v;

  savePassword(v) => this.password = v;

  nullValidate(String v) {
    if (v == null || v.length == 0) {
      return 'Required Field';
    }
  }

  login() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      AuthHelper.authHelper.signIn(email, password, context);
    }
  }

  verifyEmail() {
    AuthHelper.authHelper.sendEmailVerification(email);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                  CustomButton(title: 'Login', function: login),
                  CustomButton(
                    title: 'Send Verification Code Again',
                    function: verifyEmail,
                    backColor: 0xffF2F3F4,
                    textColor: Colors.black,
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
