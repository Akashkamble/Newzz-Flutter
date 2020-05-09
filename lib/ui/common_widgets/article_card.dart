import 'package:flutter/material.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';

class ArticleCard extends StatelessWidget {
  final Articles article;
  final Function(String url) launch;

  const ArticleCard({this.article, this.launch});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          child: Material(
            child: InkWell(
              onTap: () {
                launch(article.url);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: (article.urlToImage != null &&
                              article.urlToImage.isNotEmpty)
                          ? Image.network(
                              article.urlToImage,
                              height: constraints.maxWidth * 0.65,
                              width: constraints.maxWidth,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: constraints.maxWidth * 0.65,
                              width: constraints.maxWidth,
                            ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 4.0,
                        ),
                        child: Text(
                          '${article.title}',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16.0),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Visibility(
                      visible: article.source != null &&
                          article.source.name.isNotEmpty,
                      child: Text(
                        '${article.source.name}',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '${article.publishedAt.substring(0, 10)}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
