
import 'package:http/http.dart';
import 'dart:convert';
import 'package:clean_news_ai/src/models/Item_model.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:clean_news_ai/src/resources/keys.dart';

class NewsApiProvider {

  final prefs = SharedPreferences.getInstance();

  getNews() async {
    var response;
    final _apiKey = apikeys[Random().nextInt(4)];
    final theme = (await prefs).getString('theme');
    final lastRequest = (await prefs).getString('lastRequest');

    if (theme == null && lastRequest == null){
      response = await get("https://newsapi.org/v2/everything?q=flutter&sortBy=relevance&apiKey=$_apiKey");
    }else if (theme != null && lastRequest == null){
      var country = (await prefs).getString('lang') ?? "en";
      country == "en" ? country = "us" : (await prefs).getString('lang');
      response = await get("https://newsapi.org/v2/top-headlines?country=$country&category=$theme&apiKey=$_apiKey");
    }else {
      final lang = (await prefs).getString('lang') ?? "en";
      response = await get("https://newsapi.org/v2/everything?q=$lastRequest&sortBy=relevance&language=$lang&apiKey=$_apiKey");
    }

    if ((await response).statusCode == 200) {
      final mapArticles = {};
      ItemModel.fromJson(json.decode(response.body)).articles.forEach((article){
        mapArticles[article.url] = article;
      });
      return mapArticles;
    } else {
      throw Exception('Failed to load post');
    }
  }

  getSavedNews() async {
    final uuid = await showMyID();
    final mapSavedArticles = {};
    var articles = await Firestore.instance.collection("users").document(uuid).get();
    if(articles.data != null){
      articles.data.values.toList().forEach((value){
        var article = Article.fromMap(value);
        mapSavedArticles[article.url] = article;
      });
    }
    return mapSavedArticles;
  }

  uploadMyArticle(holder) async {
    final key = holder["url"].toString().replaceAll("/", "").replaceAll(".", "");
    final uuid = await showMyID();
    Firestore.instance.collection("users").document(uuid).setData({key : holder}, merge: true);
  }

  deleteMyArticle(url) async {
    final key = url.toString().replaceAll("/", "").replaceAll(".", "");
    final uuid = await showMyID();
    Firestore.instance.collection("users").document(uuid).updateData({key: FieldValue.delete()});
  }

  showMyID() async {
    (await prefs).getString('id') ?? saveMyID();
    return (await prefs).getString('id');
  }

  saveMyID() async {
    final myid = Uuid().v4();
    await Firestore.instance.collection("users").document(myid).get();
    await (await prefs).setString('id', myid);
  }

}