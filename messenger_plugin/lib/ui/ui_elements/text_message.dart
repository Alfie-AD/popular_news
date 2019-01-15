import 'package:flutter/material.dart';
import 'package:messenger_plugin/ui/ui_elements/circle_avatar.dart';

class TextMessage extends StatelessWidget {

  bool me;
  String message;

  TextMessage(this.me, this.message);

  build(context) {
    return Row(
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: me ?
        [
          Expanded(child: Text(message, textAlign: TextAlign.right)),
          UserAvatar()
        ]
            :
        [
          UserAvatar(),
          Expanded(child: Text(message))
        ]
      );
  }
}

class EmptyBox extends StatelessWidget {
  build( context) => Padding(padding: EdgeInsets.only(bottom: 32.0));
}
