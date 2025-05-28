import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/article_model.dart';

class NewsService {
  static const String _apiKey = 'f6b38ff8a66c2a07f6cdaa7b90a93a17';
  static const String _baseUrl = 'https://gnews.io/api/v4';

  ///Top 10 News for List
  static Future<List<Article>> fetchNews() async {
    const String url = '$_baseUrl/top-headlines?lang=en&country=in&max=10&topic=general&apikey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List articlesJson = data['articles'];
        return articlesJson.map((e) => Article.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///Top 3 News for Banner
  static Future<List<Article>> fetchBannerNews() async {
    const String url = '$_baseUrl/top-headlines?lang=en&country=in&max=3&topic=breaking-news&apikey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List articlesJson = data['articles'];
        return articlesJson.map((e) => Article.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load banner news');
      }
    } catch (e) {
      rethrow;
    }
  }
}
