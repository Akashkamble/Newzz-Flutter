import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzzflutter/blocs/article_list/article_list_event.dart';
import 'package:newzzflutter/blocs/article_list/article_list_state.dart';
import 'package:newzzflutter/blocs/article_list/tech_bloc.dart';

import '../common_widgets/common_widgets.dart';

class TechnologyListWidget extends StatefulWidget {
  @override
  _TechnologyListWidgetState createState() => _TechnologyListWidgetState();
}

class _TechnologyListWidgetState extends State<TechnologyListWidget>
    with AutomaticKeepAliveClientMixin {
  TechnologyBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _articleBloc = BlocProvider.of<TechnologyBloc>(context);
    _articleBloc.add(FetchArticleListEvent(category: 'technology'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                )),
            child: BlocBuilder<TechnologyBloc, ArticleState>(
              builder: (context, state) {
                if (state is ArticleLoadingState) {
                  return loadingWidget();
                } else if (state is ArticleLoadedState) {
                  if (MediaQuery.of(context).size.width > 800) {
                    return articleGridListWidget(
                      state.articles,
                      ((MediaQuery.of(context).size.width) / 300).round(),
                    );
                  }
                  return articleListWidget(state.articles);
                } else if (state is ArticleErrorState) {
                  return errorWidget(state.errorText);
                }
                return loadingWidget();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
