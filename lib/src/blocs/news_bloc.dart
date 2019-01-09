import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:clean_news_ai/src/models/Item_model.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allNews => _newsFetcher.stream;

  fetchAllNews() async {
    ItemModel itemModel = await _repository.getNews();
    _newsFetcher.sink.add(itemModel);
  }

  dispose() {
    _newsFetcher.close();
  }
}

final bloc = NewsBloc();