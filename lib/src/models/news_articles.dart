// To parse this JSON data, do
//
// final newsArticles = newsArticlesFromJson(jsonString);

import 'dart:convert';

import 'package:news_app/src/models/news_article.dart';

NewsArticles newsArticlesFromJson(String str) =>
    NewsArticles.fromJson(json.decode(str));

String newsArticlesToJson(NewsArticles data) => json.encode(data.toJson());

class NewsArticles {
  NewsArticles({
    this.status,
    this.totalResults,
    this.articles,
  });

  final String? status;
  final int? totalResults;
  final List<NewsArticle>? articles;

  factory NewsArticles.fromJson(Map<String, dynamic> json) => NewsArticles(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null
            ? null
            : List<NewsArticle>.from(
                json["articles"].map((x) => NewsArticle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null
            ? null
            : List<NewsArticle>.from(articles?.map((x) => x.toJson()) ?? {}),
      };
}
