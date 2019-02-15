import 'dart:async';

class SearchScreenState {

  Map cashedData = {};
  final broadcaster = StreamController.broadcast();
  get news => broadcaster.stream;

}

final state = SearchScreenState();