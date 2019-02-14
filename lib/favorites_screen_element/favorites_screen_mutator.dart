
import 'package:clean_news_ai/provider/provider.dart';
import 'favorites_screen_state.dart';

class FavoritesScreenMutator {

  getNews() async {
    state.broadcaster.add(await provider.getSavedNews());
  }

  updateStars (key) {
    if(state.cashedData.containsKey(key)){
      state.cashedData[key].liked = !state.cashedData[key].liked;
      state.broadcaster.add(state.cashedData);
    }
  }

}

final favoritesMutator = FavoritesScreenMutator();