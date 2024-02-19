import 'package:flutter/material.dart';
import 'package:news_api_task/models/article.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Article Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<bool>(
        future: Future.delayed(Duration(seconds: 2), () => true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmer();
          } else {
            return _buildContent();
          }
        },
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: double.infinity,
                height: 400.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: double.infinity,
                height: 160.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: double.infinity,
                height: 100.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: 200.0,
                height: 30.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                article.image ?? '',
                width: double.infinity,
                height: 400.0,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Center(
                      child: Image.asset('assets/images/news_image.png'));
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.schedule_outlined, color: Colors.grey, size: 16),
                SizedBox(width: 4),
                Text(
                  'Published at: ${article.publishedAt.toString()}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              article.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Wrap the content text in SingleChildScrollView
            const Divider(),
            Text(
              article.content ??
                  'The online community has flooded X with Sora memes. The world of technology is an ever-evolving field, bustling with inventions. In fact, the power of Artificial Intelligence (AI) is being explored … [+2998 chars]',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 16),
            Text(
              'Go to article',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
