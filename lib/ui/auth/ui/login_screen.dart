import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:maan_application_1/ui/auth/ui/register_screen.dart';
import 'package:maan_application_1/ui/auth/ui/widgets/custom_textfield.dart';
import 'package:maan_application_1/ui/helpers/route_helper.dart';
import 'package:maan_application_1/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Consumer<AuthProvider>(builder: (context, provider, x) {
            return Form(
              key: provider.loginKey,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Container(
                          height: 120.0,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      CustomTextfeild(
                        label: 'Email',
                        controller: provider.emailController,
                        textInputType: TextInputType.emailAddress,
                      ),
                      CustomTextfeild(
                        label: 'Password',
                        isHidden: true,
                        controller: provider.passwordController,
                      ),
                      CustomButton(
                          title: 'Login', function: provider.loginUser),
                      CustomButton(
                        title: 'Send Verification Code Again',
                        function: provider.sendVerifyEmail,
                        backColor: 0xffF2F3F4,
                        textColor: Colors.black,
                      ),
                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, left: 20, bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                provider.logout();
                                RouteHelper.routeHelper
                                    .goAndReplacePage(RegisterScreen.routeName);
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
                            margin:
                                EdgeInsets.only(top: 20, right: 20, bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                provider.logout();
                                RouteHelper.routeHelper
                                    .goAndReplacePage(RegisterScreen.routeName);
                              },
                              child: Text(
                                ' Register',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0XFFE79215),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap: () {
                                provider.logout();
                                RouteHelper.routeHelper.showCustomInputDialoug(
                                    'Reset Password', 'Enter you email');
                              },
                              child: Text(
                                'Forget password',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0XFFE79215),
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
            );
          }),
        ),
      ),
    );
  }
}
