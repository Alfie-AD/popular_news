
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class ThemeBloc {

  final _themeFetcher = PublishSubject<ThemeData>();

  Observable<ThemeData> get allNews => _themeFetcher.stream;

  fetchTheme(theme) async {
    _themeFetcher.sink.add(theme);
  }
}

final bloc = ThemeBloc();