import 'package:intl/intl.dart';

class ItemModel {
  List<_Article> _articles = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    List<_Article> temp = [];
    for (int i = 0; i < parsedJson['articles'].length; i++) {
      _Article article = _Article(parsedJson['articles'][i]);
      temp.add(article);
    }
    _articles = temp;
  }

  List<_Article> get articles => _articles;

}

class _Article {
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

  _Article(article) {
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

  Map get source => _source;
  String get author => _author;
  String get title => _title;
  String get description => _description;
  String get url => _url;
  String get urlToImage => _urlToImage;
  String get publishedAt => _publishedAt;
  String get content => _content;

}