import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/src/providers/news_app_drawer_provider.dart';
import 'package:news_app/src/providers/news_articles_list_provider.dart';
import 'package:news_app/src/utils/constants.dart';
import 'package:news_app/src/utils/routes.dart';
import 'package:provider/provider.dart';

class NewsSplashScreen extends StatefulWidget {
  const NewsSplashScreen({Key? key}) : super(key: key);

  @override
  State<NewsSplashScreen> createState() => _NewsSplashScreenState();
}

class _NewsSplashScreenState extends State<NewsSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Provider.of<NewsArticlesListProvider>(context, listen: false)
            .updateQueryString(NewsAppConstants.categories[
                Random().nextInt(NewsAppConstants.categories.length)]);
        Provider.of<NewsAppDrawerProvider>(context, listen: false)
            .updateDrawerIndex(2);
        Navigator.pushReplacementNamed(context, NewsAppRoutes.newsArticlesList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade900,
              Colors.teal,
              Colors.grey.shade900,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(
                'assets/images/breaking-news-news.gif',
                height: 300,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'The world\'s news at your fingertips!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
