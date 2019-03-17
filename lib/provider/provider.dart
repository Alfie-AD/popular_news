import 'dart:convert';
import 'dart:math';

import 'package:clean_news_ai/models/Item_model.dart';
import 'package:clean_news_ai/provider/keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

class NewsApiProvider {
  final _prefs = SharedPreferences.getInstance();
  final _fireStore = Firestore.instance;

  getNews(search) async {
    await _fireStore.settings(timestampsInSnapshotsEnabled: true);
    var response;
    final _apiKey = apikeys[Random().nextInt(4)];
    final theme = (await _prefs).getString('theme');
    final lastRequest = (await _prefs).getString('lastRequest');

    if (search == false) {
      var country = (await _prefs).getString('lang') ?? 'en';
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

    if (response.statusCode != 200) return getNews(search);

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
    var articles = await _fireStore.collection("users").document(uuid).get();
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
    final key = holder["url"].replaceAll(RegExp(r"[/.]"), "");
    final uuid = await showMyID();
    _fireStore
        .collection("users")
        .document(uuid)
        .setData({key: holder}, merge: true);
  }

  deleteMyArticle(url) async {
    final key = url.replaceAll(RegExp(r"[/.]"), "");
    final uuid = await showMyID();
    _fireStore
        .collection("users")
        .document(uuid)
        .updateData({key: FieldValue.delete()});
  }

  showMyID() async {
    (await _prefs).getString('id') ?? _saveMyID();
    return (await _prefs).getString('id');
  }

  _saveMyID() async {
    const platform = const MethodChannel('samples.flutter.io/battery');
    final lang = await platform.invokeMethod('lang');
    (await _prefs).setString("lang", lang);
    final myid = Uuid().v4();
    await _fireStore.collection("users").document(myid).get();
    (await _prefs).setString('id', myid);
  }
}

final provider = NewsApiProvider();
