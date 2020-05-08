import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ArticleEvent extends Equatable{}

class FetchArticleListEvent extends ArticleEvent{
  final String category;

  FetchArticleListEvent({@required this.category});
  @override
  List<Object> get props => [category];
}