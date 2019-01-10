import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsFetcher = PublishSubject<Map>();

  Observable<Map> get allNews => _newsFetcher.stream;

  fetchAllNews() async {
    Map articles = await _repository.getNews();
    _newsFetcher.sink.add(articles);
  }

  dispose() {
    _newsFetcher.close();
  }

}

final bloc = NewsBloc();