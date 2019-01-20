import 'package:intl/intl.dart';

class ItemModel {
  List<Article> _articles = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Article> temp = [];
    for (int i = 0; i < parsedJson['articles'].length; i++) {
      Article article = Article(parsedJson['articles'][i]);
      temp.add(article);
    }
    _articles = temp;
  }

  List<Article> get articles => _articles;

}

class Article {
  Map _source;
  String _author;
  String _title;
  String _description;
  String _url;
  String _urlToImage;
  String _publishedAt;
  String _content;
  var liked = false;
  var animated = false;

  Article(article) {
    _source = article["source"];
    _author = article["author"];
    _title = article["title"];
    _description = article["description"];
    _url = article["url"];
    _urlToImage = article["urlToImage"];
    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final unformedDate = format.parse(article["publishedAt"]);
    _publishedAt = "${unformedDate.day}/${unformedDate.month}/${unformedDate.year}";
    _content = article["content"];
  }

  Article.fromMap(map) {
    _source = { "name" : map["name"]};
    _author = "nothing";
    _title = map["title"];
    _description = "nothing";
    _url = map["url"];
    _urlToImage = map["urlToImage"];
    _publishedAt = map["publishedAt"];
    _content = "nothing";
    liked = true;
    animated = true;
  }

  Map get source => _source;
  String get author => _author;
  String get title => _title;
  String get description => _description;
  String get url => _url;
  String get urlToImage => _urlToImage;
  String get publishedAt => _publishedAt;
  String get content => _content;

}