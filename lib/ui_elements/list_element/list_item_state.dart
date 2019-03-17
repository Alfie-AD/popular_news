import 'dart:async';

class ListItemState {
  var liked;
  ListItemState(this.liked);

  var cashedImage;
  final imageBroadcaster = StreamController.broadcast();
  get imageStream => imageBroadcaster.stream;

  close() {
    imageBroadcaster.close();
  }
}
