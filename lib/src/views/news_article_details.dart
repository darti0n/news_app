import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_article.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:news_app/src/utils/news_app_url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsArticleDetails extends StatelessWidget {
  const NewsArticleDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsArticle? newsArticle = context.watch<NewsProvider>().newsArticle;
    return Scaffold(
      appBar: AppBar(
        title: Text('Source: ${newsArticle?.source?.name}'),
        actions: [
          IconButton(
            onPressed: () async {
              await Share.share(
                newsArticle?.url ?? '',
                subject: 'Share via:',
              );
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.network(
            newsArticle?.urlToImage ?? '',
            loadingBuilder: (context, child, loadingProgress) {
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
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    newsArticle?.title ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    newsArticle?.description
                            ?.replaceAll('<ol>', '')
                            .replaceAll('<li>', '')
                            .replaceAll('</li>', '') ??
                        '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (newsArticle?.author?.isNotEmpty ?? false)
                  Text('By: ${newsArticle?.author}'),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () =>
                      NewsAppUrlLauncher().launchInWebView(newsArticle?.url),
                  child: RichText(
                    text: TextSpan(
                      text: 'More info: ',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${newsArticle?.url}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
