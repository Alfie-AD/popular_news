import 'package:flutter/material.dart';


class ListItemMutator {

  final state;
  ListItemMutator(this.state);

  downloadImage(url) async {
    if(url != null){
      final image = Image.network(url).image;
      image.resolve(ImageConfiguration()).addListener((imageInfo, synchronousCall){
        state.cashedImage = image;
        state.imageBroadcaster.add(state.cashedImage);
      });
    }
  }
}