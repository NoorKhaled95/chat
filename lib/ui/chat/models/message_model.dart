import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String content;
  String senderId;
  String userName;
  String imageUrl;
  Timestamp timeStamp;
  MessageModel(this.content, this.senderId, this.userName, {this.imageUrl});
  MessageModel.fromMap(Map map) {
    this.content = map['content'];
    this.senderId = map['senderId'];
    this.userName = map['userName'];
    this.id = map['id'];
    this.timeStamp = map['createdOn'];
    this.imageUrl = map['imageUrl'];
  }
  toMap() {
    return {
      'content': this.content,
      'senderId': this.senderId,
      'userName': this.userName,
      'createdOn': FieldValue.serverTimestamp(),
      'imageUrl': this.imageUrl
    };
  }
}
