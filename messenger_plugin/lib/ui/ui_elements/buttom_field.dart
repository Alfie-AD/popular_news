import 'package:flutter/material.dart';
import 'dart:ui';


class ButtomPart extends StatelessWidget{

  build(context) {
    final bool iphonex = MediaQuery.of(context).size.height >= 812.0;
    final double bottomPadding = iphonex ? 16.0 : 0.0;
    return Container(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 10.0, sigmaX: 10.0),
          child: Container(
            color: Colors.teal.withOpacity(0.5),
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.attach_file), onPressed: null),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: "type your message here",
                      hasFloatingPlaceholder: false
                    ),
                  )
                ),
                IconButton(icon: Icon(Icons.send), onPressed: null),
              ],
            ),
          )),
      alignment: AlignmentDirectional.bottomEnd,
    );
  }
}