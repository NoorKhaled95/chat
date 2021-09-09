import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/ui/welcome_screen.dart';
import 'package:maan_application_1/ui/chat/ui/chat_page.dart';
import 'package:provider/provider.dart';

import 'ui/auth/provider/auth_provider.dart';
import 'ui/helpers/route_helper.dart';

class SplashScreen extends StatelessWidget {
  static final routeName = 'splashScreen';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      bool userExisting =
          Provider.of<AuthProvider>(context, listen: false).checkUser();
      if (userExisting) {
        RouteHelper.routeHelper.goAndReplacePage(ChatPage.routeName);
      } else {
        RouteHelper.routeHelper.goAndReplacePage(WelcomeScreen.routeName);
      }
    });
    return Scaffold(
      backgroundColor: Color(0XFFE79215),
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Container(
            height: 120.0,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
