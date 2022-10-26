import 'package:flutter/material.dart';
import 'package:news_app/src/providers/news_app_settings_provider.dart';
import 'package:news_app/src/utils/constants.dart';
import 'package:provider/provider.dart';

class NewsAppSettings extends StatefulWidget {
  const NewsAppSettings({Key? key}) : super(key: key);

  @override
  State<NewsAppSettings> createState() => _NewsAppSettingsState();
}

class _NewsAppSettingsState extends State<NewsAppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Preferred Language'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<String>(
                isExpanded: true,
                value: Provider.of<NewsAppSettingsProvider>(context)
                    .preferredLanguage,
                items: NewsAppLanguages()
                    .values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (String? preferredLanguage) {
                  Provider.of<NewsAppSettingsProvider>(context, listen: false)
                      .updatePreferredLanguage(preferredLanguage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
