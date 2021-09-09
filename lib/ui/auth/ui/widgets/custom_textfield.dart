import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomTextfeild extends StatelessWidget {
  String label;
  String text;
  TextEditingController controller;
  bool isHidden, isEnabled;
  TextInputType textInputType;

  CustomTextfeild(
      {this.label,
      this.controller,
      this.textInputType = TextInputType.text,
      this.isHidden = false,
      this.isEnabled = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextFormField(
        initialValue: text,
        enabled: isEnabled,
        obscureText: isHidden,
        keyboardType: textInputType,
        controller: this.controller,
        validator: (v) =>
            Provider.of<AuthProvider>(context, listen: false).nullValidate(v),
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0XFFE79215),
              ),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
