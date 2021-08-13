import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  int backColor;
  Color textColor;
  Function function;
  CustomButton(
      {@required this.title,
      @required this.function,
      this.backColor = 0xff2196F3,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(backColor),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        child: Text(this.title, style: TextStyle(color: textColor)),
        onPressed: () => function(),
      ),
    );
  }
}
