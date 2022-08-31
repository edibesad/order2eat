import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:order2eat/pages/cash_register_page.dart';
import 'package:order2eat/pages/webview_page.dart';
import 'package:order2eat/providers/all_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/user_model.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                label: "Cash Register",
                icon: FaIcon(FontAwesomeIcons.cashRegister)),
            BottomNavigationBarItem(
                label: "Webview", icon: FaIcon(FontAwesomeIcons.clipboard)),
            BottomNavigationBarItem(
                label: "Logout",
                icon: FaIcon(FontAwesomeIcons.arrowRightToBracket)),
          ],
          selectedItemColor: Colors.red,
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
            });
            switch (_index) {
              case 0:
                ref.read(openedPageProvider.state).state =
                    const CashRegisterPage();
                break;
              case 1:
                ref.read(openedPageProvider.state).state = const WebviewPage();
                break;
              case 2:
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        ElevatedButton(
                            onPressed: () => logout(ref),
                            child: const Text("yes").tr()),
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("no").tr())
                      ],
                      content: const Text("logout_ask").tr(),
                    );
                  },
                );

                break;
            }
          },
        );
      },
    );
  }

  Future<void> logout(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    ref.read(userProvider.state).state = UserModel();
    // ignore: use_build_context_synchronously
    if (ref.read(webViewControllerProvider.state).state != null) {
      ref.read(webViewControllerProvider.state).state!.clearCache();
      CookieManager().clearCookies();
    }
    Navigator.pop(context);
  }
}
