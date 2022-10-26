import 'package:flutter/material.dart';
import 'package:news_app/news_app.dart';
import 'package:news_app/src/providers/news_app_drawer_provider.dart';
import 'package:news_app/src/providers/news_app_settings_provider.dart';
import 'package:news_app/src/providers/news_articles_list_provider.dart';
import 'package:news_app/src/providers/news_home_page_provider.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsProvider()),
        ChangeNotifierProvider(create: (context) => NewsAppDrawerProvider()),
        ChangeNotifierProvider(create: (context) => NewsArticlesListProvider()),
        ChangeNotifierProvider(create: (context) => NewsHomePageProvider()),
        ChangeNotifierProvider(create: (context) => NewsAppSettingsProvider()),
      ],
      child: const NewsApp(),
    ),
  );
}
