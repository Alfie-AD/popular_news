import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsFetcher = PublishSubject<Map>();

  Observable<Map> get allNews => _newsFetcher.stream;

  fetchAllNews() async {
    Map articles = await _repository.getNews();
    _newsFetcher.sink.add(articles);
  }

  dispose() {
    _newsFetcher.close();
    _savedNewsFetcher.close();
  }

  final _savedNewsFetcher = PublishSubject<Map>();

  Observable<Map> get allSavedNews => _savedNewsFetcher.stream;

  fetchSavedNews() async {
    Map savedArticles = await _repository.getSavedNews();
    _savedNewsFetcher.sink.add(savedArticles);
  }

  saveArticle(holder) async {
    _repository.saveArticle(holder);
  }

  deleteArticle(url) async {
    _repository.deleteArticle(url);
  }
}

final bloc = NewsBloc();