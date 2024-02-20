import 'package:flutter/material.dart';
import 'package:news_api_task/models/article.dart';
import 'package:news_api_task/screens/article_details.dart';
import 'package:news_api_task/widgets/article_card.dart';
import 'package:page_transition/page_transition.dart';

class ArticleItem extends StatelessWidget {
  final Article article;

  const ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: ArticleDetailPage(article: article)));
      },
      child: ArticleCard(article: article),
    );
  }
}
