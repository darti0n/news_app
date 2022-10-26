import 'package:flutter/material.dart';
import 'package:news_app/src/views/news_app_settings.dart';
import 'package:news_app/src/views/news_articles_list.dart';
import 'package:news_app/src/views/news_article_details.dart';
import 'package:news_app/src/views/news_home_page.dart';

class NewsAppRoutes {
  static const String homeScreen = '/news-home-page';
  static const String newsArticlesList = '/news-articles-list';
  static const String newsArticleDetails = '/news-article-details';
  static const String newsAppSettings = '/news-app-settings';

  static final Map<String, WidgetBuilder> newsAppRoutes =
      <String, WidgetBuilder>{
    homeScreen: (context) => const NewsHomePage(),
    newsArticlesList: (context) => const NewsArticlesList(),
    newsArticleDetails: (context) => const NewsArticleDetails(),
    newsAppSettings: (context) => const NewsAppSettings(),
  };
}
