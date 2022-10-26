import 'package:flutter/material.dart';
import 'package:news_app/src/utils/routes.dart';
import 'package:news_app/src/utils/themes.dart';
import 'package:news_app/src/views/news_splash_screen.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: const NewsSplashScreen(),
      routes: NewsAppRoutes.newsAppRoutes,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: NewsAppTheme.newsAppTextTheme,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
