import 'package:dio/dio.dart';
import 'package:news_api_task/models/article.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  static const String apiKey = '744a3abafb764890949f2ca05f8bbf3e';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> getArticles({int page = 1, int pageSize = 10}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      var response = await dio.get(
          '$baseUrl/top-headlines?country=us&apiKey=$apiKey&page=$page&pageSize=$pageSize');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> articles = jsonData['articles'];

      List<Article> articlesList = [];

      for (var articleModel in articles) {
        Article? article = Article.fromJson(articleModel);

          articlesList.add(article);
      }

      return articlesList;
    } catch (e) {
      return [];
    }
  }
}
