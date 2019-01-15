import 'package:flutter/material.dart';
import 'package:messenger_plugin/ui/screen/messaging_screen.dart';

void main() => runApp(Messenger());

class Messenger extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: MessagingScreen(),
    );
  }
}


