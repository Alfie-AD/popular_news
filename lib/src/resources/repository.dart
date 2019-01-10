import 'news_api_provider.dart';

Map mainArticles ;
Map savedArticles ;

class Repository {

  final newsApiProvider = NewsApiProvider();

  getNews() async {
    if(mainArticles == null){
      mainArticles = await newsApiProvider.getNews();
      savedArticles = await newsApiProvider.getSavedNews();
      savedArticles.forEach((key, value){
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
    if(savedArticles == null){
      savedArticles = await newsApiProvider.getSavedNews();
      return savedArticles;
    }else{
      return savedArticles;
    }
  }

  saveArticle(holder) => newsApiProvider.uploadMyArticle(holder);

  deleteArticle(url) => newsApiProvider.deleteMyArticle(url);

}

updateSavedNews() async {
  final newsApiProvider = NewsApiProvider();
  savedArticles = await newsApiProvider.getSavedNews();
}


