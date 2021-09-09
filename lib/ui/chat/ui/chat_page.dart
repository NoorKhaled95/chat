import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maan_application_1/components/constants.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:maan_application_1/ui/auth/ui/login_screen.dart';
import 'package:maan_application_1/ui/chat/models/message_model.dart';
import 'package:maan_application_1/ui/chat/providers/chat_provider.dart';
import 'package:maan_application_1/ui/chat/ui/profile_page.dart';
import 'package:maan_application_1/ui/chat/ui/widgets/message_buble.dart';
import 'package:maan_application_1/ui/helpers/route_helper.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  static final routeName = 'chatScreen';

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFE79215),
        title: Text('Chat'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .editProfileNavigation();
                RouteHelper.routeHelper.goAndReplacePage(ProfilePage.routeName);
              },
              icon: Icon(Icons.person)),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              RouteHelper.routeHelper.goAndReplacePage(LoginScreen.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer<ChatProvider>(builder: (context, provider, x) {
            return Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: provider.getStream(),
                  builder: (context, querySnapshot) {
                    if (querySnapshot.hasData) {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>
                          documents = querySnapshot.data.docs;

                      List<MessageModel> messages = documents
                          .map((e) => MessageModel.fromMap(e.data()))
                          .toList();

                      List<Widget> widgets = messages.map((e) {
                        return Provider.of<AuthProvider>(context, listen: false)
                                        .userModel !=
                                    null &&
                                Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .userModel
                                        .id !=
                                    null
                            ? e.senderId ==
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .userModel
                                        .id
                                ? MessageBubble(
                                    isMe: true,
                                    sender: e.userName,
                                    text: e.content,
                                    imageUrl: e.imageUrl,
                                    timestamp: e.timeStamp != null
                                        ? e.timeStamp
                                        : Timestamp.fromDate(DateTime.now()),
                                  )
                                : MessageBubble(
                                    isMe: false,
                                    sender: e.userName,
                                    text: e.content,
                                    imageUrl: e.imageUrl,
                                    timestamp: e.timeStamp,
                                  )
                            : Text('');
                      }).toList();

                      return ListView(
                        children: widgets,
                        controller: _controller,
                      );
                    } else {
                      return Container(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          }),
          Container(
            width: double.infinity,
            height: 60.0,
            decoration: new BoxDecoration(
                border: new Border(
                    top: new BorderSide(color: Colors.blueGrey, width: 0.5)),
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                  child: new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 1.0),
                    child: new IconButton(
                        onPressed: () {
                          Provider.of<ChatProvider>(context, listen: false)
                              .selectFile();
                        },
                        icon: Icon(Icons.attach_file)),
                  ),
                  color: Colors.white,
                ),
                Flexible(
                  child: Container(
                    child: TextField(
                      onTap: () {
                        Timer(
                            Duration(milliseconds: 300),
                            () => _controller
                                .jumpTo(_controller.position.maxScrollExtent));
                      },
                      textInputAction: TextInputAction.send,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller:
                          Provider.of<ChatProvider>(context).messageController,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                ),
                Material(
                  child: new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 8.0),
                    child: new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: () {
                        Timer(
                            Duration(milliseconds: 500),
                            () => _controller
                                .jumpTo(_controller.position.maxScrollExtent));
                        Provider.of<ChatProvider>(context, listen: false)
                            .sendMessage(MessageModel(
                                Provider.of<ChatProvider>(context,
                                        listen: false)
                                    .messageController
                                    .text,
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .userModel
                                    .id,
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .userModel
                                    .userName));
                      },
                      color: Colors.blueGrey,
                    ),
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
