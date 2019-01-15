import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {

  build (context) {
    return CircleAvatar(
      child: Image.network("https://img.icons8.com/color/1600/circled-user-male-skin-type-1-2.png"),
    );
  }
}