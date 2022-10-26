import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/src/providers/news_app_drawer_provider.dart';
import 'package:news_app/src/providers/news_articles_list_provider.dart';
import 'package:news_app/src/utils/constants.dart';
import 'package:news_app/src/utils/routes.dart';
import 'package:provider/provider.dart';

class NewsAppDrawer extends StatefulWidget {
  const NewsAppDrawer({Key? key}) : super(key: key);

  @override
  State<NewsAppDrawer> createState() => _NewsAppDrawerState();
}

class _NewsAppDrawerState extends State<NewsAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade800,
      child: ListView(
        children: [
          ListTile(
            tileColor: context.watch<NewsAppDrawerProvider>().drawerIndex == 1
                ? Colors.teal
                : Colors.grey.shade800,
            leading: const Icon(
              Icons.public,
              color: Colors.white,
            ),
            title: const Text(
              'International',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Provider.of<NewsAppDrawerProvider>(context, listen: false)
                  .updateDrawerIndex(1);
              Navigator.pushNamed(context, NewsAppRoutes.homeScreen);
            },
          ),
          ListTile(
            tileColor: context.watch<NewsAppDrawerProvider>().drawerIndex == 2
                ? Colors.teal
                : Colors.grey.shade800,
            leading: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            title: const Text(
              'Everything',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Provider.of<NewsArticlesListProvider>(context, listen: false)
                  .updateQueryString(NewsAppConstants.categories[
                      Random().nextInt(NewsAppConstants.categories.length)]);
              Provider.of<NewsAppDrawerProvider>(context, listen: false)
                  .updateDrawerIndex(2);
              Navigator.pushNamed(context, NewsAppRoutes.newsArticlesList);
            },
          ),
          ListTile(
            tileColor: context.watch<NewsAppDrawerProvider>().drawerIndex == 3
                ? Colors.teal
                : Colors.grey.shade800,
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Provider.of<NewsAppDrawerProvider>(context, listen: false)
                  .updateDrawerIndex(3);
              Navigator.pushNamed(context, NewsAppRoutes.newsAppSettings);
            },
          ),
        ],
      ),
      elevation: 30,
    );
  }
}
