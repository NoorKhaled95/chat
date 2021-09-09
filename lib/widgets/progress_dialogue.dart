import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/helpers/route_helper.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressDialoge {
  ProgressDialog pr;
  String message;

  ProgressDialoge({this.message = 'wait please..'}) {
    pr = ProgressDialog(RouteHelper.routeHelper.navigationKey.currentContext);
    pr = ProgressDialog(RouteHelper.routeHelper.navigationKey.currentContext,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: SizedBox(
        height: 5,
        width: 5,
        child: CircularProgressIndicator(
          color: Colors.black26,
        ),
      ),
      textAlign: TextAlign.center,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
  }

  show() async {
    await pr.show();
  }

  dismiss() async {
    pr.hide().then((isHidden) {
      print(isHidden);
    });

// or
    await pr.hide();
  }
}
