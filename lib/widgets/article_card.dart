import 'package:flutter/material.dart';
import 'package:news_api_task/models/article.dart';
import 'package:shimmer/shimmer.dart';

class ArticleCard extends StatefulWidget {
  final Article article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  widget.article.image ?? '',
                  width: double.infinity,
                  height: 200.0,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Center(
                      child: Image.asset('assets/images/news_image.png'),
                    );
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.0),
                Text(
                  widget.article.description ?? '',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: 8.0),
                  Row(
                  children: [
                    Icon(Icons.calendar_today,
                        color: Colors.grey, size: 16),
                    SizedBox(width: 4),
                    Text(
                      widget.article.publishedAt.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
