import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_article.dart';
import 'package:news_app/src/models/news_articles.dart';
import 'package:news_app/src/providers/news_articles_list_provider.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:news_app/src/services/news_articles_list_service.dart';
import 'package:news_app/src/utils/constants.dart';
import 'package:news_app/src/utils/routes.dart';
import 'package:news_app/src/views/news_app_drawer.dart';
import 'package:provider/provider.dart';

class NewsArticlesList extends StatefulWidget {
  const NewsArticlesList({Key? key}) : super(key: key);

  @override
  State<NewsArticlesList> createState() => _NewsArticlesListState();
}

class _NewsArticlesListState extends State<NewsArticlesList> {
  NewsArticles? newsArticles;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  getData() async {
    newsArticles = await NewsArticlesListService().getData(context);
    if (newsArticles != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<NewsArticle>? filteredArticles = newsArticles?.articles
        ?.where((article) => article.urlToImage != null)
        .toList();

    if (Provider.of<NewsArticlesListProvider>(context).errorMsg.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            Provider.of<NewsArticlesListProvider>(context).errorMsg,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NewsAppRoutes.newsAppSettings);
              },
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      drawer: const NewsAppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<NewsArticlesListProvider>(context, listen: false)
              .updateQueryString(
            NewsAppConstants.categories[
                Random().nextInt(NewsAppConstants.categories.length)],
          );
          await getData();
        },
        child: SingleChildScrollView(
          child: Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade800,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Ex: technology',
                                  border: InputBorder.none,
                                ),
                                onChanged: (String qString) =>
                                    Provider.of<NewsArticlesListProvider>(
                                            context,
                                            listen: false)
                                        .updateQueryString(qString),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoaded = false;
                                  });
                                  await getData();
                                },
                                child: const Icon(Icons.search),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredArticles?.length ?? 0,
                    itemBuilder: (context, articleIndex) {
                      NewsArticle newsArticle =
                          filteredArticles?[articleIndex] ?? NewsArticle();
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Material(
                          elevation: 3,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Provider.of<NewsProvider>(context,
                                          listen: false)
                                      .updateArticle(newsArticle);
                                  Navigator.pushNamed(
                                    context,
                                    NewsAppRoutes.newsArticleDetails,
                                  );
                                },
                                leading: SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Image.network(
                                    newsArticle.urlToImage ?? '',
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const Center(
                                        child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        const Icon(Icons.broken_image_rounded),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  newsArticle.title!.length > 75
                                      ? (newsArticle.title ?? '').replaceRange(
                                          75, newsArticle.title?.length, '...')
                                      : newsArticle.title ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
