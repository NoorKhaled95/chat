import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maan_application_1/components/colors.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {this.sender, this.text, this.timestamp, this.isMe, this.imageUrl});
  final String sender;
  final String text;
  final Timestamp timestamp;
  final bool isMe;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return imageUrl == null
        ? Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  sender,
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
                Material(
                  borderRadius: isMe
                      ? BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        )
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                  elevation: 5.0,
                  color: isMe
                      ? PalletteColors.primaryGrey
                      : PalletteColors.lightBlue,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: isMe ? Colors.white : Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            "${DateFormat('h:mm a').format(dateTime)}",
                            style: TextStyle(
                              fontSize: 9.0,
                              color: isMe
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.black54.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  sender,
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
                Material(
                  elevation: 5.0,
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: isMe
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  topLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                )
                              : BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                        ),
                        height: 200,
                        width: 200,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "${DateFormat('h:mm a').format(dateTime)}",
                          style: TextStyle(
                            fontSize: 9.0,
                            color: isMe
                                ? Colors.black54.withOpacity(0.5)
                                : Colors.black54.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
