import 'dart:async';
import 'package:news_api_task/models/article.dart';
import 'package:news_api_task/utils/api_service.dart';

class ArticleService {
  final ApiService apiService;
  final StreamController<List<Article>> _articleController = StreamController.broadcast();

  ArticleService(this.apiService);

  Stream<List<Article>> get articleStream => _articleController.stream;

  Future<void> fetchArticles() async {
    try {
      List<Article> articles = await apiService.getArticles();
      _articleController.add(articles);
    } catch (e) {
      _articleController.addError(e);
    }
  }

  void dispose() {
    _articleController.close();
  }
}
