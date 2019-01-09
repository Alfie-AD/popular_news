import 'news_api_provider.dart';

class Repository {
  final newsApiProvider = NewsApiProvider();
  getNews() => newsApiProvider.getNews();

}