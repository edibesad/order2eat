import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:order2eat/widgets/cash_register/cash_register_checkout.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("checkout").tr(),
        ),
        body: Column(
          children: const [
            Expanded(child: CashRegisterCheckout()),
          ],
        ));
  }
}
