import 'dart:async';
import 'package:news_api_task/models/article.dart';
import 'package:news_api_task/utils/api_service.dart';

class ArticleService {
  final ApiService apiService;
  final StreamController<List<Article>> _articleController = StreamController.broadcast();
  static const int _pageSize = 10;
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool hasMoreData = true;

  ArticleService(this.apiService);

  Stream<List<Article>> get articleStream => _articleController.stream;

  List<Article> myArticles = [];

  Future<void> fetchArticles() async {
    try {
      if (_isLoadingMore) return;

      _isLoadingMore = true;

      List<Article> articles = await apiService.getArticles(page: _currentPage, pageSize: _pageSize);
      myArticles = myArticles + articles;
      hasMoreData = articles.length == _pageSize;
      // Update state based on response
      _isLoadingMore = false;
      _currentPage++;

      // Add/append articles to existing list
      _articleController.add(myArticles); // Use stream.value
    } catch (e) {
      _articleController.addError(e);
    }
  }

  void dispose() {
    _articleController.close();
  }
}
