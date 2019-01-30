import '../resources/repository.dart';
import 'dart:async';

class NewsBloc {
  final _repository = Repository();
  var _controllerNews = StreamController.broadcast();
  var _controllerSaved = StreamController.broadcast();
  get news => _controllerNews.stream;
  get saved => _controllerSaved.stream;

  fetchAllNews() async {
    _controllerNews.add(await _repository.getNews());
    Stream.periodic(Duration(hours: 1)).listen((onData) async {
      mainArticles.clear();
      _controllerNews.add(await _repository.getNews());
    });
  }

  fetchSavedNews() async => _controllerSaved.add(await _repository.getSavedNews());

  saveArticle(holder) async => _repository.saveArticle(holder);

  deleteArticle(url) async => _repository.deleteArticle(url);

}

final bloc = NewsBloc();