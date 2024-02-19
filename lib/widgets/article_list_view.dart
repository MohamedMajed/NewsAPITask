import 'package:flutter/material.dart';
import 'package:news_api_task/models/article.dart';
import 'package:news_api_task/screens/article_details.dart';
import 'package:news_api_task/widgets/article_card.dart';

class ArticlesListView extends StatelessWidget {
  final List<Article> articles;

  const ArticlesListView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(
                      article: articles[index]),
                ),
              );
            },
            child: ArticleCard(article: articles[index]),
          );
        },
        childCount: articles.length,
      ),
    );
  }
}