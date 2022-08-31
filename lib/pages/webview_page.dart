import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/providers/all_providers.dart';
import 'package:order2eat/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:order2eat/widgets/drawer/app_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Web view"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return WebView(
            initialCookies: [
              WebViewCookie(
                  name: "id",
                  value: ref.read(userProvider.state).state.user!.id.toString(),
                  domain: "https://order2eat.dk/checkout/orderList")
            ],
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: "https://order2eat.dk/checkout/orderList",
            onWebViewCreated: (controller) {
              _webViewController = controller;
              controller.loadUrl("https://order2eat.dk/checkout/orderList");
              controller.runJavascriptReturningResult(
                  "var tablo = \$('.row.hidden-print').clone(); \$('body div').hide(); \$('body').append(tablo);");
            },
          );
        },
      ),
    );
  }
}
