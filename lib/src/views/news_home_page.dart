import 'package:flutter/material.dart';
import 'package:news_app/src/providers/news_articles_list_provider.dart';
import 'package:news_app/src/providers/news_home_page_provider.dart';
import 'package:news_app/src/utils/constants.dart';
import 'package:news_app/src/utils/routes.dart';
import 'package:news_app/src/views/news_app_drawer.dart';
import 'package:provider/provider.dart';

class NewsHomePage extends StatelessWidget {
  const NewsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News by Country'),
      ),
      drawer: const NewsAppDrawer(),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: NewsAppCountries().values.length,
        itemBuilder: (context, index) {
          String country = NewsAppCountries().values[index];
          return InkWell(
            onTap: () {
              Provider.of<NewsHomePageProvider>(context, listen: false)
                  .updateCountry(country);
              Provider.of<NewsArticlesListProvider>(context, listen: false)
                  .updateQueryString('');
              Navigator.pushNamed(context, NewsAppRoutes.newsArticlesList);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Text(
                    country,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
