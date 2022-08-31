import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:order2eat/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:order2eat/widgets/drawer/app_drawer.dart';
import 'package:sized_context/sized_context.dart';
import '../widgets/cash_register/cash_register_menus.dart';
import 'package:order2eat/widgets/cash_register/cash_register_checkout.dart';

class CashRegisterPage extends StatelessWidget {
  const CashRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.diagonalInches > 8
        ? showAsRow(context)
        : showWithButton(context);
  }
}

showWithButton(BuildContext context) {
  return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        title: const Text(
          "checkout_screen",
          style: TextStyle(color: Colors.black),
        ).tr(),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Scaffold(body: CashRegisterCheckout()),
          ));
        },
      ),
      body: const SafeArea(child: CashRegisterMenus()));
}

Scaffold showAsRow(BuildContext context) {
  return Scaffold(
    drawer: const AppDrawer(),
    appBar: AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          icon: Icon(
            Icons.stacked_bar_chart,
            color: Colors.black,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
      elevation: 0,
      title: const Text(
        "checkout_screen",
        style: TextStyle(
          color: Colors.black,
        ),
      ).tr(),
      backgroundColor: Colors.white,
    ),
    body: SafeArea(
      child: Row(
        children: const [
          SizedBox(
            height: 5,
          ),
          Expanded(flex: 1, child: CashRegisterCheckout()),
          VerticalDivider(),
          Expanded(
            flex: 2,
            child: CashRegisterMenus(),
          )
        ],
      ),
    ),
  );
}
