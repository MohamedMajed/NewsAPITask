import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerArticleCard extends StatelessWidget {

  const ShimmerArticleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 250.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                  Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 80.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                  Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100.0,
                    height: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
