import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:clean_news_ai/src/models/Item_model.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsFetcher = PublishSubject<ItemModel>();
  final _savedNewsFetcher = PublishSubject<List>();

  Observable<ItemModel> get allNews => _newsFetcher.stream;
  Observable<List> get allSavedNews => _savedNewsFetcher.stream;

  fetchAllNews() async {
    ItemModel itemModel = await _repository.getNews();
    _newsFetcher.sink.add(itemModel);
  }

  fetchSavedNews() async {
    List savedArticles = await _repository.getSavedNews();
    _savedNewsFetcher.sink.add(savedArticles);
  }

  dispose() {
    _newsFetcher.close();
    _savedNewsFetcher.close();
  }

  saveArticle(holder) async {
    _repository.saveArticle(holder);
  }

  deleteArticle(url) async {
    _repository.deleteArticle(url);
  }
}

final bloc = NewsBloc();