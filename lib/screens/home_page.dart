import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_api_task/models/article.dart';
import 'package:news_api_task/utils/api_service.dart';
import 'package:news_api_task/utils/article_service.dart';
import 'package:news_api_task/widgets/article_card_shimmer.dart';
import 'package:news_api_task/widgets/article_list_view.dart';

enum NetworkStatus { loading, loaded, error }

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ArticleService _articleService = ArticleService(ApiService(Dio()));

  @override
  void initState() {
    super.initState();
    _articleService.fetchArticles();
  }

  @override
  void dispose() {
    _articleService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            leading: Icon(
              Icons.article,
              color: Colors.white,
            ),
            expandedHeight: 100,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.lightBlueAccent,
              ),
              title: Text(
                'A R T I C L E S  H U B',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          StreamBuilder<List<Article>>(
            stream: _articleService.articleStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ArticlesListView(articles: snapshot.data!);
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading articles'));
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => const ShimmerArticleCard(),
                    childCount: 5,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
