import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/providers/all_providers.dart';
import 'package:order2eat/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:order2eat/widgets/drawer/app_drawer.dart';
import 'package:sized_context/sized_context.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  // ignore: unused_field
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          context.diagonalInches > 8 ? null : const BottomNavBar(),
      drawer: context.diagonalInches < 8 ? null : const AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _webViewController.goBack();
              },
              icon: Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () {
                _webViewController.reload();
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                _webViewController.goForward();
              },
              icon: Icon(Icons.arrow_forward)),
        ],
        title: const Text("Web View"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.watch(userProvider.state).state;
          print(ref.watch(userProvider.state).state.user!.id);
          return WebView(
            initialCookies: [
              WebViewCookie(
                  name: "id",
                  value:
                      ref.watch(userProvider.state).state.user!.id.toString(),
                  domain: "https://order2eat.dk/dashboard")
            ],
            navigationDelegate: (navigation) async {
              if (navigation.url.contains("intent")) {
                String url = "rawbt:base64" + navigation.url;
                print(url);
                url = url.replaceAll("base64intent:", "");
                await launchUrl(Uri.parse(url));
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: "https://order2eat.dk/checkout/orderList",
            onWebViewCreated: (controller) {
              _webViewController = controller;
              ref.read(webViewControllerProvider.state).state = controller;
              _webViewController
                  .loadUrl("https://order2eat.dk/checkout/orderList");
            },
          );
        },
      ),
    );
  }
}
