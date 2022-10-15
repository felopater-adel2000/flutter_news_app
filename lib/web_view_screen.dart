
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';

class WebViewScreen extends StatelessWidget
{
  late String url;
  WebViewScreen(String url)
  {
    this.url = url;
  }
  @override
  Widget build(BuildContext context)
  {
    printDebug("start buils Web View Screen");
    return Scaffold(
      appBar: AppBar(),
      body: WebView(initialUrl: url,),
    );
  }
}