import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/models/user_model.dart';
import 'package:order2eat/pages/cash_register_page.dart';
import 'package:order2eat/pages/webview_page.dart';
import 'package:order2eat/providers/all_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return ListView(
            children: [
              DrawerHeader(child: Consumer(
                builder: (context, ref, child) {
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => logout(ref),
                              icon: const Icon(Icons.exit_to_app),
                            ),
                            Text(
                                "${ref.read(userProvider.state).state.user!.name!} ${ref.read(userProvider.state).state.user!.surname!}")
                          ],
                        ),
                      )
                    ],
                  );
                },
              )),
              ListTile(
                title: const Text("Cash Register"),
                onTap: () {
                  ref.read(openedPageProvider.state).state =
                      const CashRegisterPage();
                },
              ),
              ListTile(
                title: const Text("Web View"),
                onTap: () {
                  ref.read(openedPageProvider.state).state =
                      const WebviewPage();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  logout(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    if (ref.read(webViewControllerProvider.state).state != null) {
      await ref
          .read(webViewControllerProvider.state)
          .state!
          .loadUrl("https://order2eat.dk/login/logout");
    }
    prefs.clear();
    ref.read(userProvider.state).state = UserModel();
  }
}
