
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:clean_news_ai/src/models/Item_model.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class NewsApiProvider {

  final client = Client();
  final _apikeys = ["4a9de7c7c1744832aef0285f0cc75bc9",
                    "a678b44ee60b4f749f73bed294392a4c",
                    "d04bc399bff24e7bb988439c656921dc",
                    "09c38b96af7343ecb8ef347239f43e0c",
                    "fccb95d038a44cd1b8f41e5a9fd559bc",
                    "797cbd5fe1f94ffe8bd190755904b0b6",
                    "c76c51820b88496ea4481dde3794682b",
                    "91b1adf498204257b9207a82cbcbad36",
                    "99568112380744649303b6af7e87dea7"];

  getNews() async {
    var response;

    final prefs = await SharedPreferences.getInstance();
    final _apiKey = _apikeys[Random().nextInt(8)];
    final theme = prefs.getString('theme');
    final lastRequest = prefs.getString('lastRequest');

    if (theme == null && lastRequest == null){
      response = await client.get("https://newsapi.org/v2/everything?q=flutter&sortBy=relevance&apiKey=$_apiKey");
    }else if (theme != null && lastRequest == null){
      response = await client.get("https://newsapi.org/v2/top-headlines?country=us&category=$theme&apiKey=$_apiKey");
    }else {
      response = await client.get("https://newsapi.org/v2/everything?q=$lastRequest&sortBy=relevance&apiKey=$_apiKey");
    }

    if (response.statusCode == 200) {
      final mapArticles = {};
      ItemModel.fromJson(json.decode(response.body)).articles.forEach((article){
        mapArticles[article.url] = article;
      });
      return mapArticles;
    } else {
      getNews();
      throw Exception('Failed to load post');
    }
  }

  getSavedNews() async {
    final uuid = await showMyID();
    final mapSavedArticles = {};
    var articles = await Firestore.instance.collection("users").document(uuid).get();
    if(articles.data != null){
      articles.data.values.toList().forEach((value){
        value["animated"] = false;
        mapSavedArticles[value["url"]] = value;
      });
      return mapSavedArticles;
    }
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
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('id') == null ? saveMyID() : null;
    return prefs.getString('id');
  }

  saveMyID() async {
    final prefs = await SharedPreferences.getInstance();
    final myid = Uuid().v4();
    await Firestore.instance.collection("users").document(myid).get();
    await prefs.setString('id', myid);
  }
}