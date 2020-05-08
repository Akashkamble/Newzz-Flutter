import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzzflutter/blocs/article_list/article_list_event.dart';
import 'package:newzzflutter/blocs/article_list/article_list_state.dart';
import 'package:newzzflutter/blocs/article_list/general_bloc.dart';

import '../common_widgets/common_widgets.dart';

class GeneralListWidget extends StatefulWidget {
  @override
  _GeneralListWidgetState createState() => _GeneralListWidgetState();
}

class _GeneralListWidgetState extends State<GeneralListWidget>
    with AutomaticKeepAliveClientMixin {
  GeneralBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _articleBloc = BlocProvider.of<GeneralBloc>(context);
    _articleBloc.add(FetchArticleListEvent(category : 'general'));
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
            child: BlocBuilder<GeneralBloc, ArticleState>(
              builder: (context, state) {
                if (state is ArticleLoadingState) {
                  return loadingWidget();
                } else if (state is ArticleLoadedState) {
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
