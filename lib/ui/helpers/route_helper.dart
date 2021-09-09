import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:maan_application_1/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class RouteHelper {
  RouteHelper._();
  static RouteHelper routeHelper = RouteHelper._();
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  goToPage(String routeName) {
    navigationKey.currentState.pushNamed(routeName);
  }

  goAndReplacePage(String routeName) {
    navigationKey.currentState.pushReplacementNamed(routeName);
  }

  goBack() {
    navigationKey.currentState.pop();
  }

  showCustomInputDialoug(String title, String content) {
    return showDialog(
        context: navigationKey.currentContext,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset Password'),
            content: TextField(
              controller: Provider.of<AuthProvider>(context, listen: false)
                  .passwordController,
              decoration: InputDecoration(hintText: "Enter your email"),
            ),
            actions: <Widget>[
              CustomButton(
                  title: 'OK',
                  function: () =>
                      Provider.of<AuthProvider>(context, listen: false)
                          .resetPassword(
                              Provider.of<AuthProvider>(context, listen: false)
                                  .passwordController
                                  .text)),
            ],
          );
        });
  }

  showCustomDialoug(String contente) {
    showDialog(
        context: navigationKey.currentContext,
        builder: (context) {
          return AlertDialog(
            content: Text(contente),
            actions: [CustomButton(title: 'ok', function: goBack())],
          );
        });
  }
}
