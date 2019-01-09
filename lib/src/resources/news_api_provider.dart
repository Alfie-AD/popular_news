
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:clean_news_ai/src/models/Item_model.dart';

class NewsApiProvider {
  final client = Client();
  final _apiKey = '91b1adf498204257b9207a82cbcbad36';

  getNews() async {
    final response = await client.get("https://newsapi.org/v2/top-headlines?country=us&category=general&pageSize=30&apiKey=$_apiKey");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}