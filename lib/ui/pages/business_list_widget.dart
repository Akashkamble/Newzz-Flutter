import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzzflutter/blocs/article_list/article_list_event.dart';
import 'package:newzzflutter/blocs/article_list/article_list_state.dart';
import 'package:newzzflutter/blocs/article_list/business_bloc.dart';

import '../common_widgets/common_widgets.dart';

class BusinessListWidget extends StatefulWidget {
  @override
  _BusinessListWidgetState createState() => _BusinessListWidgetState();
}

class _BusinessListWidgetState extends State<BusinessListWidget>
    with AutomaticKeepAliveClientMixin {
  BusinessBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _articleBloc = BlocProvider.of<BusinessBloc>(context);
    _articleBloc.add(FetchArticleListEvent(category: 'business'));
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
            child: BlocBuilder<BusinessBloc, ArticleState>(
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
