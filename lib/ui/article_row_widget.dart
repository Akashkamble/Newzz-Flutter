import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:newzzflutter/constants/dimens.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';

class ArticleWidget extends StatelessWidget {
  final Articles article;
  final Function launch;

  const ArticleWidget({this.article, this.launch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimen.leftRightPadding,
        Dimen.topBottomPadding,
        Dimen.leftRightPadding,
        Dimen.topBottomPadding,
      ),
      child: InkWell(
        onTap: launch,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: article.source != null &&
                          article.source.name.isNotEmpty,
                      child: Text(
                        '${article.source.name}',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Text(
                        '${article.title}',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '${article.publishedAt.substring(0, 10)}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:
                  (article.urlToImage != null && article.urlToImage.isNotEmpty)
                      ? Image.network(
                          article.urlToImage,
                          height: Dimen.articleImageSize,
                          width: Dimen.articleImageSize,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: Dimen.articleImageSize,
                          height: Dimen.articleImageSize,
                        ),
            ),
          ],
        ),
      ),
    );
  }
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
        animation: new CustomTabsAnimation(
          startEnter: 'slide_up',
          startExit: 'android:anim/fade_out',
          endEnter: 'android:anim/fade_in',
          endExit: 'slide_down',
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
