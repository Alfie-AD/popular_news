import 'news_api_provider.dart';

class Repository {
  final newsApiProvider = NewsApiProvider();

  getNews() => newsApiProvider.getNews();

  saveArticle(holder) => newsApiProvider.uploadMyArticle(holder);

  deleteArticle(url) => newsApiProvider.deleteMyArticle(url);

  getSavedNews() => newsApiProvider.getSavedNews();
}