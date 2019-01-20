import 'news_api_provider.dart';

class Repository {

  final newsApiProvider = NewsApiProvider();

  getNews() async {
    if(mainArticles.isEmpty && savedArticles.isEmpty){
      mainArticles = await newsApiProvider.getNews();
      savedArticles = await newsApiProvider.getSavedNews() ?? {};
      savedArticles.forEach((key, value){
        if(mainArticles.containsKey(key)){
          mainArticles[key].liked = true;
        }
      });
      return mainArticles;
    }else if (mainArticles.isEmpty){
      mainArticles = await newsApiProvider.getNews();
      savedArticles?.forEach((key, value){
        if(mainArticles.containsKey(key)){
          mainArticles[key].liked = true;
        }
      });
      return mainArticles;
    }else{
      return mainArticles;
    }
  }

  getSavedNews() async {
    return savedArticles;
  }

  saveArticle(holder) => newsApiProvider.uploadMyArticle(holder);

  deleteArticle(url) => newsApiProvider.deleteMyArticle(url);

}

updateSavedNews() async {
  final newsApiProvider = NewsApiProvider();
  savedArticles = await newsApiProvider.getSavedNews();
}

Map mainArticles = {};
Map savedArticles = {};

