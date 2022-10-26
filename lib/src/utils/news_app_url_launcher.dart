import 'package:url_launcher/url_launcher.dart';

class NewsAppUrlLauncher {
  Future<void> launchInWebView(String? url) async {
    Uri uri = Uri.parse(url ?? '');
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch URL';
    }
  }
}
