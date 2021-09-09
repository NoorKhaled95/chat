import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget {
  String label;
  String content;
  IconData icon;
  ItemWidget(this.label, this.content, this.icon);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(4),
        child: Card(
          color: Color(0XFFF0F0F0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(8),
            width: 300,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.black26,
                  size: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    content,
                    style: Provider.of<AuthProvider>(context, listen: false)
                        .bodyStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
