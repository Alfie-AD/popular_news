
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';


class SavedNewsBloc{
  final _repository = Repository();
  final _savedNewsFetcher = PublishSubject<Map>();

  Observable<Map> get allSavedNews => _savedNewsFetcher.stream;

  fetchSavedNews() async {
    Map savedArticles = await _repository.getSavedNews();
    _savedNewsFetcher.sink.add(savedArticles);
  }

  saveArticle(holder) async {
    _repository.saveArticle(holder);
  }

  deleteArticle(url) async {
    _repository.deleteArticle(url);
  }

}

final bloc = SavedNewsBloc();