import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:news_demo/src/model/source_model.dart';

class APIManager {
  final _newsUrl =
      'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=03c1808da4cc41b98bfdb514dcdfc97c';
  Future<NewsModel> getNews() async {
    Client client = Client();
    var newsModel = null;

    try {
      var response = await client.get(Uri.parse('$_newsUrl'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }
    return newsModel;
  }
}
