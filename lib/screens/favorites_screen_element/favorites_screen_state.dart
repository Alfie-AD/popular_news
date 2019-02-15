import 'dart:async';

class FavoritesScreenState {

  Map cashedData = {};
  final broadcaster = StreamController.broadcast();
  get news => broadcaster.stream;

}

final state = FavoritesScreenState();