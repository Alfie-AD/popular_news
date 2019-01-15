import 'package:flutter/material.dart';
import 'package:messenger_plugin/ui/ui_elements/text_message.dart';
import 'package:messenger_plugin/ui/ui_elements/buttom_field.dart';

class MessagingScreen extends StatefulWidget {

  createState() => MessagingScreenState();
}

class MessagingScreenState extends State<MessagingScreen> {

  build(context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("UserAccountName"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            reverse: true,
            children: <Widget>[
              EmptyBox(),
              TextMessage(true, "Hello"),
              TextMessage(false, "Hi!"),
              TextMessage(true, "How are you?"),
              TextMessage(true, "hope you fine"),
              TextMessage(false, "I am ok"),
              TextMessage(true, "Nc!"),
            ],
          ),
         ButtomPart()
        ],
      ),
    );
  }

}