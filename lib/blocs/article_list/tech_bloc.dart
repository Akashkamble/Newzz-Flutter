import 'package:bloc/bloc.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';
import 'package:newzzflutter/domain/repositories/article_repo.dart';
import 'package:meta/meta.dart';

import 'article_list_event.dart';
import 'article_list_state.dart';
class TechnologyBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepo articleRepo;

  TechnologyBloc({@required this.articleRepo});

  @override
  ArticleState get initialState => ArticleLoadingState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticleListEvent) {
      yield ArticleLoadingState();
      try {
        List<Articles> list = await articleRepo.getArticles(event.category);
        yield ArticleLoadedState(articles: list);
      } catch (e) {
        yield ArticleErrorState(errorText: '$e');
      }
    }
  }
}