import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ListItemMutator {

  final state;
  ListItemMutator(this.state);

  downloadImage(url) async {
    if(url != null){
      state.cashedImage = Image(image: CachedNetworkImageProvider(url)).image;
      state.cashedImage.resolve(ImageConfiguration()).addListener((imageInfo, synchronousCall){
        state.imageBroadcaster.add(state.cashedImage);
      });
    }
  }
}