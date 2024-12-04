import 'package:url_launcher/url_launcher.dart';

class URLLauncher {

static Future<void> openMap(double latitude, double longitude) async {
  final Uri googleUrl = Uri.parse( 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude');
  await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
}
}
