import 'package:flutter/material.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';
import 'package:newzzflutter/ui/common_widgets/article_card.dart';
import 'package:newzzflutter/utils/custom_tab_utils.dart';

import 'article_row_widget.dart';

Widget loadingWidget() {
  return Center(
    child: const CircularProgressIndicator(),
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
        launch: (url) => CustomTabHelper.launchURL(context, url),
      );
    },
    itemCount: articles.length,
  );
}

Widget articleGridListWidget(List<Articles> articles, int count) {
  return GridView.builder(
    itemCount: articles.length,
    padding: const EdgeInsets.all(8.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
    itemBuilder: (BuildContext context, int index) {
      return ArticleCard(
        article: articles[index],
        launch: (url) => CustomTabHelper.launchURL(context, url),
      );
    },
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
