import 'package:flutter/material.dart';
import 'package:order2eat/widgets/drawer/app_drawer.dart';
import 'package:sized_context/sized_context.dart';
import '../widgets/cash_register/cash_register_menus.dart';
import 'package:order2eat/widgets/cash_register/cash_register_checkout.dart';

class CashRegisterPage extends StatelessWidget {
  const CashRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.diagonalInches >= 10 ? showAsRow() : showWithButton(context);
  }
}

showWithButton(BuildContext context) {
  return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Cash Register")),
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

Scaffold showAsRow() {
  return Scaffold(
    drawer: const AppDrawer(),
    appBar: AppBar(title: const Text("Cash Register")),
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
