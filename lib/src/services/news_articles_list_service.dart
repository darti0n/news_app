import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_articles.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/src/providers/news_app_settings_provider.dart';
import 'package:news_app/src/providers/news_articles_list_provider.dart';
import 'package:news_app/src/providers/news_home_page_provider.dart';
import 'package:news_app/src/utils/constants.dart';
import 'package:provider/provider.dart';

class NewsArticlesListService {
  Future<NewsArticles?> getData(BuildContext context) async {
    NewsArticlesListProvider newsArticlesListProvider =
        Provider.of<NewsArticlesListProvider>(context, listen: false);
    NewsHomePageProvider newsHomePageProvider =
        Provider.of<NewsHomePageProvider>(context, listen: false);
    NewsAppSettingsProvider newsAppSettingsProvider =
        Provider.of<NewsAppSettingsProvider>(context, listen: false);
    String host = 'https://newsapi.org/v2/';
    String endpoint = '';
    String query = '';
    String language = '';
    language =
        'language=${NewsAppLanguages.languageMap.keys.firstWhere((key) => NewsAppLanguages.languageMap[key] == newsAppSettingsProvider.preferredLanguage)}&';

    if (newsHomePageProvider.country.isNotEmpty) {
      endpoint = 'top-headlines?country=${newsHomePageProvider.country}&';
      query = '';
      language = '';
    }

    if (newsArticlesListProvider.queryString.isNotEmpty) {
      endpoint = 'everything?';
      query = 'q=${newsArticlesListProvider.queryString}';
    }

    Uri uri = Uri.parse('$host$endpoint$language$query');
    if (uri.toString().endsWith('&')) {
      uri = Uri.parse(uri.toString().substring(0, uri.toString().length - 1));
    }

    try {
      var response = await http.get(
        uri,
        headers: <String, String>{
          'Authorization': NewsAppConstants.apiKey,
        },
      );
      return newsArticlesFromJson(response.body);
    } catch (e) {
      Provider.of<NewsArticlesListProvider>(
        context,
        listen: false,
      ).updateErrorMsg(
        e.toString(),
      );
    }
  }
}
