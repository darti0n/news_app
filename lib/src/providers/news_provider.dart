import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_article.dart';

class NewsProvider with ChangeNotifier {
  NewsArticle? _newsArticle;

  NewsArticle? get newsArticle => _newsArticle;

  void updateArticle(NewsArticle? newsArticle) {
    _newsArticle = newsArticle;
    notifyListeners();
  }
}
