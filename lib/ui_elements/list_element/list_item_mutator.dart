import 'package:flutter/material.dart';

class ListItemMutator {

  final state;
  ListItemMutator(this.state);

  downloadImage(url) async {
    if(url != null){
      state.cashedImage = Image.network(url).image;
      state.cashedImage.resolve(ImageConfiguration()).addListener((imageInfo, synchronousCall){
        state.imageBroadcaster.add(state.cashedImage);
      });
    }
  }
}