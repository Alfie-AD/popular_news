
import 'package:clean_news_ai/provider/provider.dart';
import 'main_screen_state.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';

class MainScreenMutator extends AbstractMutator {

  const MainScreenMutator(state) : super(state);

  getNews() async {
    state.cashedData = await provider.getNews(false);
    state.broadcaster.add(state.cashedData);
  }

}

final mainMutator = MainScreenMutator(state);