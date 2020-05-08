import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newzzflutter/blocs/article_list/article_list_event.dart';
import 'package:newzzflutter/blocs/article_list/article_list_state.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';
import 'package:newzzflutter/domain/repositories/article_repo.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepo articleRepo;

  ArticleBloc({@required this.articleRepo});

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
