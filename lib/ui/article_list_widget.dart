import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:newzzflutter/blocs/article_list/article_list_bloc.dart';
import 'package:newzzflutter/blocs/article_list/article_list_event.dart';
import 'package:newzzflutter/blocs/article_list/article_list_state.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';
import 'package:newzzflutter/ui/article_row_widget.dart';

class ArticleListWidget extends StatefulWidget {
  final String _category;

  const ArticleListWidget(this._category);

  @override
  _ArticleListWidgetState createState() => _ArticleListWidgetState();
}

class _ArticleListWidgetState extends State<ArticleListWidget>
    with AutomaticKeepAliveClientMixin {
  String title = '';
  ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
    _articleBloc.add(FetchArticleListEvent(category: widget._category));
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
            child: BlocBuilder<ArticleBloc, ArticleState>(
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

  Widget loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget articleListWidget(List<Articles> articles) {
  return ListView.separated(
    separatorBuilder: (BuildContext context, int index) =>
        Divider(height: 2, color: Colors.grey),
    padding: EdgeInsets.zero,
    itemBuilder: (context, index) {
      return ArticleWidget(
        article: articles[index],
        launch: () => _launchURL(context, articles[index].url),
      );
    },
    itemCount: articles.length,
  );
}

Widget errorWidget(String error) {
  return Center(
    child: Text(
      '$error',
      style: TextStyle(fontSize: 20.0),
      textAlign: TextAlign.center,
    ),
  );
}

void _launchURL(BuildContext context, String url) async {
  try {
    await launch(
      '$url',
      option: new CustomTabsOption(
        toolbarColor: Theme.of(context).primaryColor,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        animation: const CustomTabsAnimation(
          startEnter: 'android:anim/slide_in_right',
          startExit: 'android:anim/slide_out_left',
          endEnter: 'android:anim/slide_in_left',
          endExit: 'android:anim/slide_out_right',
        ),
        extraCustomTabs: <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
        ],
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}
