import 'package:flutter/material.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';
import 'package:newzzflutter/utils/custom_tab_utils.dart';

import 'article_row_widget.dart';

Widget loadingWidget() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget articleListWidget(List<Articles> articles) {
  return ListView.separated(
    separatorBuilder: (BuildContext context, int index) =>
        Divider(height: 2, color: Colors.grey),
    padding: EdgeInsets.zero,
    itemBuilder: (context, index) {
      return ArticleWidget(
        article: articles[index],
        launch: () => CustomTabHelper.launchURL(context, articles[index].url),
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