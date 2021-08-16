import 'package:flutter/material.dart';

class CustomTextfeild extends StatelessWidget {
  String label;
  Function validate;
  Function save;
  bool isHidden;
  TextInputType textInputType;
  CustomTextfeild(
      {this.label,
      this.save,
      this.validate,
      this.textInputType = TextInputType.text,
      this.isHidden = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextFormField(
        obscureText: isHidden,
        keyboardType: textInputType,
        onSaved: (v) => save(v),
        validator: (v) => validate(v),
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0Xffdd5a44),
              ),
            ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.white),
            // ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
