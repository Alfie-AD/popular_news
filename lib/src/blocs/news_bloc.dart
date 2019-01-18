import '../resources/repository.dart';

class NewsBloc {
  final _repository = Repository();

  Stream news;
  Stream savedNews;

  fetchAllNews() async {
    news = Stream.fromFuture(_repository.getNews());
  }

  fetchSavedNews() async {
    savedNews = Stream.fromFuture(_repository.getSavedNews());
  }

  saveArticle(holder) async {
    _repository.saveArticle(holder);
  }

  deleteArticle(url) async {
    _repository.deleteArticle(url);
  }
}

final bloc = NewsBloc();