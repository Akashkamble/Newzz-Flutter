import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';

abstract class ArticleState extends Equatable {}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object> get props => [];
}

@immutable
class ArticleLoadedState extends ArticleState {
  final List<Articles> articles;

  ArticleLoadedState({@required this.articles});

  @override
  List<Object> get props => [articles];
}

@immutable
class ArticleErrorState extends ArticleState {
  final String errorText;

  ArticleErrorState({@required this.errorText});

  @override
  List<Object> get props => [errorText];
}
