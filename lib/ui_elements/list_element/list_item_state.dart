import 'package:flutter/material.dart';
import 'dart:async';

class ListItemState {

  var liked;
  ListItemState(this.liked);

  var cashedImage = Image.asset("assets/oad.png").image;
  final imageBroadcaster = StreamController.broadcast();
  get imageStream => imageBroadcaster.stream;

}