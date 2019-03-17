import 'package:flutter/material.dart';
import 'list_item_state.dart';

class ListItemMutator {
  final ListItemState state;
  ListItemMutator(this.state);

  downloadImage(url) async {
    if(state.cashedImage == null){
      state.cashedImage = Image.network(url).image;
      state.cashedImage.resolve(ImageConfiguration()).addListener((imageInfo, synchronousCall){
        state.imageBroadcaster.add(state.cashedImage);
      });
    }else{
      state.imageBroadcaster.add(state.cashedImage);
    }
  }
}