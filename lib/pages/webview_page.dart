import 'package:flutter/material.dart';
import 'package:order2eat/widgets/drawer/app_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Web view"),
      ),
      body: WebView(initialUrl: "https://www.flutter.dev/"),
    );
  }
}
