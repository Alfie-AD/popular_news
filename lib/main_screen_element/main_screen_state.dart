import 'dart:async';

class MainScreenState {

  Map cashedData = {};
  final broadcaster = StreamController.broadcast();
  get news => broadcaster.stream;


}

final state = MainScreenState();