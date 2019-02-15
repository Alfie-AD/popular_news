
import 'package:clean_news_ai/provider/provider.dart';
import 'search_screen_state.dart';

class SearchScreenMutator {

  getNews() async {
    state.cashedData = await provider.getNews(true);
    state.broadcaster.add(state.cashedData);
  }

  updateStars (key) {
    if(state.cashedData.containsKey(key)){
      state.cashedData[key].liked = !state.cashedData[key].liked;
      state.broadcaster.add(state.cashedData);
    }
  }

}

final searchMutator = SearchScreenMutator();