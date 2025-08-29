import 'package:url_launcher/url_launcher.dart';

class LaunchUrl{

  static Future<void> launchWebUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}