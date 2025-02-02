import 'package:webview_flutter/webview_flutter.dart';

final controller = WebViewController()
  ..loadRequest(
    Uri.parse('https://example.com'),
  );
