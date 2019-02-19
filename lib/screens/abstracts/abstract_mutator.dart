
import 'package:clean_news_ai/provider/provider.dart';


class AbstractMutator {

  final state;
  const AbstractMutator(this.state);

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