
import 'package:clean_news_ai/provider/provider.dart';
import 'search_screen_state.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';

class SearchScreenMutator extends AbstractMutator {

  const SearchScreenMutator(state) : super(state);

  getNews() async {
    state.cashedData = await provider.getNews(true);
    state.broadcaster.add(state.cashedData);
  }

}

final searchMutator = SearchScreenMutator(state);