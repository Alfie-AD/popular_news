import 'package:clean_news_ai/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractMutator {
  final state;
  AbstractMutator(this.state);
  final _prefs = SharedPreferences.getInstance();

  getNews() async {
    state.broadcaster.add(null);
    state.cashedData = {};
    final themes = (await _prefs).getStringList('themes') ?? [];
    if (themes.isNotEmpty) {
      themes.forEach((theme) async {
        state.cashedData.addAll(await provider.getNews(false, theme));
        state.broadcaster.add(state.cashedData);
      });
    } else {
      state.cashedData.addAll(await provider.getNews(false, "mixed"));
      state.broadcaster.add(state.cashedData);
    }
  }

  updateStars(key) {
    if (state.cashedData.containsKey(key)) {
      state.cashedData[key].liked = !state.cashedData[key].liked;
      state.broadcaster.add(state.cashedData);
    }
  }
}
