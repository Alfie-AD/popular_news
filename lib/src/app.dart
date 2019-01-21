import 'package:flutter/material.dart';
import 'ui/parent_screen.dart';

class App extends StatelessWidget {

  build(context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ParentScreen(),
      ),
    );
  }
}