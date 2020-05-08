import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:newzzflutter/constants/constants.dart';
import 'package:newzzflutter/domain/exceptions/excpetions.dart';
import 'package:newzzflutter/domain/model/article_response_model.dart';

abstract class ArticleRepo {
  Future<List<Articles>> getArticles(String category);
}

class ArticleRepoImpl implements ArticleRepo {
  final apiKey = Constants.apiKey;

  @override
  Future<List<Articles>> getArticles(String category) async {
    final url =
        'https://newsapi.org/v2/top-headlines?sortBy=publishedAt&pageSize=100&category=$category&country=in&apiKey=$apiKey';
    final List<Articles> list = List<Articles>();
    try {
      final response = await http.get(url);
      list.addAll(_parseResponse(response));
    } on SocketException {
      throw NetworkConnectionException('No connection');
    }
    return list;
  }

  List<Articles> _parseResponse(http.Response response) {
    List<Articles> list = List();
    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(response.body.toString());
        list.addAll(ArticleResponse.fromJson(responseJson).articles);
        break;
      case 400:
        throw BadRequestException(_getErrorMessage(response));
      case 401:
      case 403:
        throw UnauthorisedException(_getErrorMessage(response));
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
    return list;
  }

  String _getErrorMessage(http.Response response) {
    final errorJson = json.decode(response.body.toString());
    return errorJson['message'];
  }
}
