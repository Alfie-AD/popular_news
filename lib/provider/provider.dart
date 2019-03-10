import 'dart:convert';
import 'dart:math';

import 'package:clean_news_ai/models/Item_model.dart';
import 'package:clean_news_ai/provider/keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NewsApiProvider {
  final _prefs = SharedPreferences.getInstance();

  getNews(search) async {
    var response;
    final _apiKey = apikeys[Random().nextInt(4)];
    final theme = (await _prefs).getString('theme');
    final lastRequest = (await _prefs).getString('lastRequest');

    if (search == false) {
      var country = (await _prefs).getString('lang') ?? "en";
      country == "en" ? country = "us" : (await _prefs).getString('lang');
      theme != null
          ? response = await get(
              "https://newsapi.org/v2/top-headlines?country=$country&category=$theme&apiKey=$_apiKey")
          : response = await get(
              "https://newsapi.org/v2/top-headlines?country=$country&apiKey=$_apiKey");
    } else {
      final lang = (await _prefs).getString('lang') ?? "en";
      response = await get(
          "https://newsapi.org/v2/everything?q=$lastRequest&sortBy=relevance&language=$lang&apiKey=$_apiKey");
    }

    final mapArticles = {};
    ItemModel.fromJson(json.decode(response.body)).articles.forEach((article) {
      mapArticles[article.url] = article;
    });
    final savedArticles = await getSavedNews();
    savedArticles?.forEach((key, value) {
      if (mapArticles.containsKey(key)) {
        mapArticles[key].liked = true;
      }
    });
    return mapArticles;
  }

  getSavedNews() async {
    final uuid = await showMyID();
    final mapSavedArticles = {};
    var articles =
        await Firestore.instance.collection("users").document(uuid).get();
    if (articles.data != null) {
      articles.data.values.toList().forEach((value) {
        var article = Article.fromMap(value);
        mapSavedArticles[article.url] = article;
        mapSavedArticles[article.url].liked = true;
      });
    }
    return mapSavedArticles;
  }

  uploadMyArticle(holder) async {
    final key =
        holder["url"].toString().replaceAll(new RegExp(r"[/.]"), "");
    final uuid = await showMyID();
    Firestore.instance
        .collection("users")
        .document(uuid)
        .setData({key: holder}, merge: true);
  }

  deleteMyArticle(url) async {
    final key = url.toString().replaceAll(new RegExp(r"[/.]"), "");
    final uuid = await showMyID();
    Firestore.instance
        .collection("users")
        .document(uuid)
        .updateData({key: FieldValue.delete()});
  }

  showMyID() async {
    (await _prefs).getString('id') ?? _saveMyID();
    return (await _prefs).getString('id');
  }

  _saveMyID() async {
    final myid = Uuid().v4();
    await Firestore.instance.collection("users").document(myid).get();
    (await _prefs).setString('id', myid);
  }
}

final provider = NewsApiProvider();
