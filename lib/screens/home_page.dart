import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_api_task/models/article.dart';
import 'package:news_api_task/screens/article_details.dart';
import 'package:news_api_task/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:news_api_task/widgets/article_card.dart';
import 'package:news_api_task/widgets/article_card_shimmer.dart';
import 'package:news_api_task/widgets/article_list_view.dart';
import 'package:shimmer/shimmer.dart';

enum NetworkStatus { loaded, loading, error, idle }

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> articles = [];

  final ApiService apiService = ApiService(Dio());

  NetworkStatus networkStatus = NetworkStatus.idle;


  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  void _loadArticles() async {
    try {
      networkStatus = NetworkStatus.loading;
      List<Article> fetchedArticles = await apiService.getArticles();

      setState(() {
        articles = fetchedArticles;
        networkStatus = NetworkStatus.loaded;
      });
    } catch (e) {
      print('Failed to load articles: $e');
      log('Failed to load articles: $e');
      networkStatus = NetworkStatus.error;
    }
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
          networkStatus == NetworkStatus.loading ||
                  networkStatus == NetworkStatus.idle
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return const ShimmerArticleCard();
                    },
                    childCount: 5,
                  ),
                )
              : (networkStatus == NetworkStatus.error
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return const Center(
                          child: Text('Error found!'),
                        );
                      },
                      childCount: 1,
                    ))
                  : ArticlesListView(
                      articles: articles,
                    ))
        ],
      ),
    );
  }
}
