
import 'package:clean_news_ai/provider/provider.dart';
import 'main_screen_state.dart';

class MainScreenMutator {

  getNews() async {
    state.cashedData = await provider.getNews(false);
    state.broadcaster.add(state.cashedData);
  }

  updateStars (key) {
    if(state.cashedData.containsKey(key)){
      state.cashedData[key].liked = !state.cashedData[key].liked;
      state.broadcaster.add(state.cashedData);
    }
  }

}

final mainMutator = MainScreenMutator();