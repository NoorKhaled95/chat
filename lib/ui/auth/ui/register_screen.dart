import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/models/register_request.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:maan_application_1/ui/auth/ui/login_screen.dart';
import 'package:maan_application_1/ui/auth/ui/widgets/custom_textfield.dart';
import 'package:maan_application_1/ui/helpers/route_helper.dart';
import 'package:maan_application_1/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static final routeName = 'registerScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Consumer<AuthProvider>(builder: (context, provider, x) {
            return Form(
              key: provider.registerKey,
              child: SingleChildScrollView(
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
                      height: 32,
                    ),
                    CustomTextfeild(
                      label: 'Email',
                      controller: provider.emailController,
                      textInputType: TextInputType.emailAddress,
                      isEnabled: true,
                    ),
                    CustomTextfeild(
                      label: 'Password',
                      isHidden: true,
                      controller: provider.passwordController,
                    ),
                    CustomTextfeild(
                      label: 'User Name',
                      controller: provider.userNameController,
                    ),
                    CustomTextfeild(
                      label: 'Phone',
                      controller: provider.phoneController,
                      textInputType: TextInputType.phone,
                    ),
                    CustomTextfeild(
                      label: 'Country',
                      controller: provider.countryController,
                    ),
                    CustomTextfeild(
                      label: 'City',
                      controller: provider.cityController,
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
                                  groupValue: provider.selectedGender,
                                  onChanged: (value) {
                                    provider.saveGender(value);
                                  }),
                              RadioListTile(
                                  title: Text('Female'),
                                  value: Gender.female,
                                  groupValue: provider.selectedGender,
                                  onChanged: (value) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .saveGender(value);
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                        title: 'Register', function: provider.registerNewUser),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          provider.logout();
                          RouteHelper.routeHelper
                              .goAndReplacePage(LoginScreen.routeName);
                        },
                        child: Text(
                          'Do you have an account? Login',
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
              ),
            );
          }),
        ),
      ),
    );
  }
}
