class Article {
  String title;
  String? description;
  String? image;
  DateTime publishedAt;
  String? content;
  String? articleUrl;

  Article({
    required this.title,
    required this.description,
    required this.image,
    required this.publishedAt,
    required this.content,
    required this.articleUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json["title"],
    description: json["description"],
    image: json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],
    articleUrl: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "urlToImage": image,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
    "url": articleUrl,
  };
}